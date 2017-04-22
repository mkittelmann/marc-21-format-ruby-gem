require 'marc21format/marclocgov'
require 'marc21format/marser'
require 'rest-client'
require 'nokogiri'
require 'pp'

 
  # Access the MARC21 format documentation
  # https://www.loc.gov/marc/bibliographic/ecbdlist.html
  #
  # Simplifies the creation of validation tools
  # or for use as CLI reference.
  #
  #  
  #
  #
  # == Getting started 
  #
  #      require 'marc21format'
  # 
  #      marc = MARC21Format.new   # load format live from web
  # 
  #      marc = MARC21Format.new( 'marc21.txt' )  # load format from a text file
  #
  #
  # == Usage
  #
  # ========= Full text search (case insensitive)
  #       pp marc.find( 'my-search-term' )
  #       pp marc.find( 'nonfiling' )
  #       => will return the full description of any tag any part of which matches the search term
  #
  # ========= Specific search
  # To query for tags, subfields, and indicators use the `get` method:
  #       pp marc.get '245$a'    # => "$a - Title (NR)"
  #       pp marc.get '245i1=1'  # => "1 - Added entry"
  #       pp marc.get '245i1'    
  #       #=> {"245 - TITLE STATEMENT (NR)"=> {"First - Title added entry"=>["0 - No added entry", "1 - Added entry"]}}
  #       pp marc.get '245' 
  #       #=> {"245 - TITLE STATEMENT (NR)"=>
  #       #     {"Indicators"=>
  #       #       {"First - Title added entry"=>["0 - No added entry", "1 - Added entry"],
  #       #         "Second - Nonfiling characters"=>["0-9 - Number of nonfiling characters"]},
  #       #      "Subfield Codes"=>
  #       #       ["$a - Title (NR)",
  #       #       "$b - Remainder of title (NR)",
  #       #       "$c - Statement of responsibility, etc. (NR)",
  #       #       "$d - Designation of section (SE) [OBSOLETE]",
  #       #       "$e - Name of part/section (SE) [OBSOLETE]",
  #       #       "$f - Inclusive dates (NR)",
  #       #       "$g - Bulk dates (NR)",
  #       #       "$h - Medium (NR)",
  #       #       "$k - Form (R)",
  #       #       "$n - Number of part/section of a work (R)",
  #       #       "$p - Name of part/section of a work (R)",
  #       #       "$s - Version (NR)",
  #       #       "$6 - Linkage (NR)",
  #       #       "$8 - Field link and sequence number (R)"]}}
  #
  # ========= Syntax for specific search
  # To search for a subfield use the tag, followed by the '$' sign and the subfield code, e.g. 
  #       '245$a' 
  #       '245 $a' # spaces are optional
  #
  # To search for an indicator use the tag, followed by a lower case letter 'i' and '1' oder '2' depending on which indicator position you want to search for, e.g. 
  #       '856i1'
  #       '856 i1' # spaces are optional
  #       '856i2'
  #       '856 i2' # spaces are optional
  #
  # To search for a specific indicator value append the equal sign '=' and the value searched for, e.g.
  #       '856i1=4'
  #       '856 i1=4' # spaces are optional
  #
  # Example:
  #       pp marc.get_indicator( '856i1=4' )
  #       pp marc.get_indicator( '856 i1=4' ) # spaces are optional
  #
  #
  # ========= Other available commands
  #
  #       pp marc.subfield_repeatable?( '856$b' )   # => true
  #       pp marc.subfield_repeatable?( '856$h' )   # => false
  #       pp marc.subfield_repeatable?( '856$7' )   # => nil (i.e. subfield does not exist)
  #
  #       pp marc.get_subfields( '856' )            # same as marc.get( '856$' )
  #       pp marc.get_subfields( '001' )            # => {}
  #
  #       pp marc.get_subfield( '856$b' )           # same as marc.get( '856$b' )
  #       pp marc.get_subfield( '856$7' )           # => '' 
  #
  #       pp marc.get_tags_with_indicators          # useful to generate validation params
  #       pp marc.get_tags_without_indicators       #
  #       pp marc.get_defined_indicators            #
  #       pp marc.get_undefined_indicators          #
  #
  #       pp marc.get_indicators( '856' )           # same as marc.get( '856i' )
  #       pp marc.get_indicators( '001' )           # => {}
  #
  #       pp marc.get_indicator( '856i1=4' )        # same as marc.get( '856i=4' )
  #
  #
  #
  # == Usage as CLI reference
  #
  # For use with IRB suppress return output:
  #
  #       irb(main):001:0> irb --simple-prompt --noecho
  #
  # You can also suppress return output in irb on a by-line basis:
  #
  #       irb(main):001:0> marc = MARC21Format.new;0    # => 0
  #
  # Commands can then be used as described above.
  #
  # ---
  #
  # Copyright (c) 2017 Maike Kittelmann
  #
  # MARC21-Format is freely distributable under the terms of MIT license.
  # See LICENSE file or http://www.opensource.org/licenses/mit-license.php
  #
  # Disclaimer: The software comes without any warranty.
  
  
class MARC21Format

  attr_reader :marc

  def initialize( file = '' )
    m = Marser.new( file )
    @marc = m.marc
  end
  
  def each
    marc.each
  end
    
  def find( str )
    marc.select { |k,v| { k => v } if ( k.match( /#{str}/i ) || v.to_s.match( /#{str}/i ) ) } 
  end
  
  def get( syntax )
    case syntax
      when /\$.+i/
        abort 'You cannot query a subfield and an indicator in the same statement'
      when /\$[^ ]/
        get_subfield( syntax )
      when /\$\s*$/
        get_subfields( syntax.sub( '$', '' ) )
      when /i.+=./
        get_indicator( syntax )
      when /i./
        tag, indicator = syntax.split( /\s*i/ )
        indicator = indicator.sub( '1', 'First' ).sub( '2', 'Second' )
        get_indicators( tag ).select { |k,v| { k => v } if v.delete_if { |kk,vv| vv if !kk.match( /#{indicator}/ ) } }
     when /\d+/
        get_tag( syntax )
    end
  end
  
  # Example return format:
  #   {"856 - ELECTRONIC LOCATION AND ACCESS (R)"=>
  #   {"First - Access method"=>
  #    ["# - No information provided",
  #    "0 - Email",
  #    "1 - FTP",
  #    "2 - Remote login (Telnet)",
  #    "3 - Dial-up",
  #    "4 - HTTP",
  #    "7 - Method specified in subfield $2"],
  #   "Second - Relationship"=>
  #    ["# - No information provided",
  #    "0 - Resource",
  #    "1 - Version of resource",
  #    "2 - Related resource",
  #    "8 - No display constant generated"]}}
  #    
  def get_tag( tag )
    marc.select { |k,v| { k => v } if k.match( /^#{tag}/ ) }
  end
  
  # Example return:
  #  "856 - ELECTRONIC LOCATION AND ACCESS (R)"=>
  #  {"First - Access method"=>
  #   ["# - No information provided",
  #   "0 - Email",
  #   "1 - FTP",
  #   "2 - Remote login (Telnet)",
  #   "3 - Dial-up",
  #   "4 - HTTP",
  #   "7 - Method specified in subfield $2"],
  #  "Second - Relationship"=>
  #   ["# - No information provided",
  #   "0 - Resource",
  #   "1 - Version of resource",
  #   "2 - Related resource",
  #   "8 - No display constant generated"]},
  #
  def get_tags_with_indicators
    marc.inject({}) do |h, (k,v)|
      if v.is_a?( Hash ) && v['Indicators']
        h = h.merge( k => v['Indicators'] )
      end
      h
    end
  end
  
   
  def get_indicators( tag )
    marc.inject({}) do |h, (k,v)|
      if v.is_a?( Hash ) && v['Indicators'] && k.match( tag )
        h = h.merge( k => v['Indicators'] )
      end
      h
    end
  end

# 
# Returns a hash with all tags that do not have any indicators.
#   
  def get_tags_without_indicators
    marc.inject({}) do |h, (k,v)|
      if !v.is_a?( Hash ) || !v['Indicators']
        h = h.merge( k => v )
      end
      h
    end
  end  

# 
# Returns a hash with all tags concerned and their undefined indicator positions.
#   
# Example return format (excerpt):
#   "886 - FOREIGN MARC INFORMATION FIELD (R)"=>
#   {"Second - Undefined"=>["# - Undefined"]},
#   "887 - NON-MARC INFORMATION FIELD (R)"=>
#   {"First - Undefined"=>["# - Undefined"],
#   "Second - Undefined"=>["# - Undefined"]}  
#
  def get_undefined_indicators
    marc.inject({}) do |h, (k,v)|
      if v.is_a?( Hash ) && v['Indicators']
        v['Indicators'].inject({}) do |hash, (key,value)|  
          if key.match( /Undefined/ )
            hash[k] && hash[k] = hash[k].merge( key => value )
            !hash[k] && hash[k] = { key => value }
          end
          h = h.merge( hash )
        end
      end
      h
    end
  end
  

# 
# Returns a hash with all tags and only their defined indicator positions.
#     
  def get_defined_indicators
    marc.inject({}) do |h, (k,v)|
      if v.is_a?( Hash ) && v['Indicators']
        v['Indicators'].inject({}) do |hash, (key,value)|  
          if !key.match( /Undefined/ )
            hash[k] && hash[k] = hash[k].merge( key => value )
            !hash[k] && hash[k] = { key => value }
          end
          h = h.merge( hash )
        end
      end
      h
    end
  end
  
# Example return format:
#   "4 - HTTP"
  def get_indicator( tag_and_indicator )
    tag, indicator = tag_and_indicator.split( /\s*i/ )
    indicator, value = indicator.split( /\s*=/ )
    indicators = get_indicators( tag )
    indicators.values.flatten.each do |hash|
      hash.each_pair do |k, v|
        case indicator
          when '1'
            v.map { |ind| return ind if ind.match( /^#{value}/ ) } if k.match( /^First - / )
          when '2'
            v.map { |ind| return ind if ind.match( /^#{value}/ ) } if k.match( /^Second - / )        
        end
      end
    end
    ''
  end


  # Returns all subfields of a certain tag.
  #
  # Example return format:
  #   {"856 - ELECTRONIC LOCATION AND ACCESS (R)"=>
  #   ["$a - Host name (R)",
  #   "$b - Access number (R)",
  #   "$c - Compression information (R)",
  #   "$d - Path (R)",
  #   "$f - Electronic name (R)",
  #   "$g - Uniform Resource Name (R) [OBSOLETE]",
  #   "$h - Processor of request (NR)",
  #   "$i - Instruction (R)",
  #   "$j - Bits per second (NR)",
  #   "$k - Password (NR)",
  #   "$l - Logon (NR)",
  #   "$m - Contact for access assistance (R)",
  #   "$n - Name of location of host (NR)",
  #   "$o - Operating system (NR)",
  #   "$p - Port (NR)",
  #   "$q - Electronic format type (NR)",
  #   "$r - Settings (NR)",
  #   "$s - File size (R)",
  #   "$t - Terminal emulation (R)",
  #   "$u - Uniform Resource Identifier (R)",
  #   "$v - Hours access method available (R)",
  #   "$w - Record control number (R)",
  #   "$x - Nonpublic note (R)",
  #   "$y - Link text (R)",
  #   "$z - Public note (R)",
  #   "$2 - Access method (NR)",
  #   "$3 - Materials specified (NR)",
  #   "$6 - Linkage (NR)",
  #   "$8 - Field link and sequence number (R)"]}
  #  
  def get_subfields( tag )
    marc.inject({}) do |h, (k,v)|
      if v.is_a?( Hash ) && v['Subfield Codes'] && k.match( tag )
        h = h.merge( k => v['Subfield Codes'] )
      end
      h
    end
  end
 
  
# Example return format:
#   "$b - Access number (R)"
#  
  def get_subfield( tag_and_subfield )
    tag, subfield = tag_and_subfield.split( /\s*\$/ )
    subfields = get_subfields( tag )
    subfields.values.flatten.each do |sf|
      return sf if sf.match( /^\$#{subfield}/ ) 
    end
    ''
  end

#
# Returns 
# * +true+ if subfield is repeatable
# * +false+ if subfield ist not repeatable
# * +nil+ if the subfield does not exist
#  
  def subfield_repeatable?( tag_and_subfield )
    tag, subfield = tag_and_subfield.split( /\s*\$/ )
    subfields = get_subfields( tag )
    subfields.values.flatten.each do |sf|
      if sf.match( /^\$#{subfield}/ ) 
        return true if sf.match( /^\$#{subfield}.+\(R\)$/ ) 
        return false
      end
    end    
    nil 
  end
  
  
  def get_indicator_values
  
  end
  
  def get_subfield_values
  
  end
    
end
