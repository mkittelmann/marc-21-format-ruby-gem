require 'marc21format/marclocgov'
require 'marc21format/marser'
require 'pp'
require 'nokogiri'
require 'rest-client'

class MARC21Format

  # marc = MARC21Format.new
  # marc = MARC21Format.new( 'marc21.txt' )

  # pp marc.get_tags_with_indicators
  # pp marc.get_tags_without_indicators

  # pp marc.get_defined_indicators
  # pp marc.get_undefined_indicators

  # pp marc.get_indicators( '856' )
  # pp marc.get_indicators( '001' )  ## => {}

  # pp marc.get_subfields( '856' )
  # pp marc.get_subfields( '001' )   ## => {}

  # pp marc.get_subfield( '856$b' )
  # pp marc.get_subfield( '856$b' )
  # pp marc.get_subfield( '856$7' )  ## => ''

  # pp marc.subfield_repeatable?( '856$b' )   ## => true
  # pp marc.subfield_repeatable?( '856$h' )   ## => false
  # pp marc.subfield_repeatable?( '856$7' )   ## => nil

  # pp marc.get_indicator( '856i1=4' )

  # pp marc.find( 'nonfiling' )




  attr_reader :marc_raw, :marc

  def initialize( file = '' )
    m = Marser.new( file )
    @marc = m.marc
    @marc_raw = m.marc_raw
  end
 
  ## indicators:

  def get_tags_with_indicators
    marc.inject({}) do |h, (k,v)|
      if v.is_a?( Hash ) && v['Indicators']
        h = h.merge( k => v['Indicators'] )
      end
      h
    end
  end
  ## return format:
   # "856 - ELECTRONIC LOCATION AND ACCESS (R)"=>
  # {"First - Access method"=>
    # ["# - No information provided",
     # "0 - Email",
     # "1 - FTP",
     # "2 - Remote login (Telnet)",
     # "3 - Dial-up",
     # "4 - HTTP",
     # "7 - Method specified in subfield $2"],
   # "Second - Relationship"=>
    # ["# - No information provided",
     # "0 - Resource",
     # "1 - Version of resource",
     # "2 - Related resource",
     # "8 - No display constant generated"]},

  def get_indicators( tag )
    marc.inject({}) do |h, (k,v)|
      if v.is_a?( Hash ) && v['Indicators'] && k.match( tag )
        h = h.merge( k => v['Indicators'] )
      end
      h
    end
  end
  ## return format:
  # {"856 - ELECTRONIC LOCATION AND ACCESS (R)"=>
  # {"First - Access method"=>
    # ["# - No information provided",
     # "0 - Email",
     # "1 - FTP",
     # "2 - Remote login (Telnet)",
     # "3 - Dial-up",
     # "4 - HTTP",
     # "7 - Method specified in subfield $2"],
   # "Second - Relationship"=>
    # ["# - No information provided",
     # "0 - Resource",
     # "1 - Version of resource",
     # "2 - Related resource",
     # "8 - No display constant generated"]}}
  
  def get_tags_without_indicators
    marc.inject({}) do |h, (k,v)|
      if !v.is_a?( Hash ) || !v['Indicators']
        h = h.merge( k => v )
      end
      h
    end
  end  

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
 ## return format:
 # "886 - FOREIGN MARC INFORMATION FIELD (R)"=>
  # {"Second - Undefined"=>["# - Undefined"]},
 # "887 - NON-MARC INFORMATION FIELD (R)"=>
  # {"First - Undefined"=>["# - Undefined"],
   # "Second - Undefined"=>["# - Undefined"]}
  
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
  ## return format:
  # "4 - HTTP"
  
  ## subfields:
  
  def get_subfields( tag )
    marc.inject({}) do |h, (k,v)|
      if v.is_a?( Hash ) && v['Subfield Codes'] && k.match( tag )
        h = h.merge( k => v['Subfield Codes'] )
      end
      h
    end
  end
  ## return format:
  # {"856 - ELECTRONIC LOCATION AND ACCESS (R)"=>
  # ["$a - Host name (R)",
   # "$b - Access number (R)",
   # "$c - Compression information (R)",
   # "$d - Path (R)",
   # "$f - Electronic name (R)",
   # "$g - Uniform Resource Name (R) [OBSOLETE]",
   # "$h - Processor of request (NR)",
   # "$i - Instruction (R)",
   # "$j - Bits per second (NR)",
   # "$k - Password (NR)",
   # "$l - Logon (NR)",
   # "$m - Contact for access assistance (R)",
   # "$n - Name of location of host (NR)",
   # "$o - Operating system (NR)",
   # "$p - Port (NR)",
   # "$q - Electronic format type (NR)",
   # "$r - Settings (NR)",
   # "$s - File size (R)",
   # "$t - Terminal emulation (R)",
   # "$u - Uniform Resource Identifier (R)",
   # "$v - Hours access method available (R)",
   # "$w - Record control number (R)",
   # "$x - Nonpublic note (R)",
   # "$y - Link text (R)",
   # "$z - Public note (R)",
   # "$2 - Access method (NR)",
   # "$3 - Materials specified (NR)",
   # "$6 - Linkage (NR)",
   # "$8 - Field link and sequence number (R)"]}
  
  
  def get_subfield( tag_and_subfield )
    tag, subfield = tag_and_subfield.split( /\s*\$/ )
    subfields = get_subfields( tag )
    subfields.values.flatten.each do |sf|
      return sf if sf.match( /^\$#{subfield}/ ) 
    end
    ''
  end
  ## return format:
  # "$b - Access number (R)"
  
  def subfield_repeatable?( tag_and_subfield )
    tag, subfield = tag_and_subfield.split( /\s*\$/ )
    subfields = get_subfields( tag )
    subfields.values.flatten.each do |sf|
      if sf.match( /^\$#{subfield}/ ) 
        return true if sf.match( /^\$#{subfield}.+\(R\)$/ ) 
        return false
      end
    end    
    nil ## i.e. "Subfield #{tag_and_subfield} does not exist."
  end
  
  # other:
  
  def find( str )
    marc.select { |k,v| { k => v } if ( k.to_s.match( /#{str}/i ) || v.to_s.match( /#{str}/i ) ) } 
  end
    
end