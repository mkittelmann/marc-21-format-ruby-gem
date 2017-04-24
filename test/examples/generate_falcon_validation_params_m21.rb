require 'marc21format'
require 'pp'
require 'jsonpathv2'
require 'facets/string/titlecase'

 # '#010 "Library of Congress Control Number" #I_ #J_ #Sa:12:<b.z.8.> ;'


class Falcon
  attr_reader :marc
  
  def initialize
    @marc = MARC21Format.new   # load format live from web
  end
  
  def generate_validation_params
    params = @marc.marc.each_with_object([]) do |(k,v), par|
      tag, description = k.split( / - / )
      par << validate( tag, description )
    end
    params.join( "\n" )
  end
  
  def validate_subfields( tag )
    # '#Sa:12:<b.z.8.>'
    sf = marc.get_subfields( tag )
    if sf && !sf.empty?
      validator = sf.values[0].each_with_object( '#S<' ) do |subfield, str|
        next unless subfield
        subfield = subfield[0] if subfield.class == Array
        code, description = subfield.sub( /^\$/, '' ).split( ' - ' )
        repeatable = description && description.match( '\(NR\)' ) ? '' : '.'
        str << code.strip + repeatable
      end
    end
    validator += '>' if validator
    validator || ''
  end
  
  def validate_indicators( tag )
    #'#I_ #J_'
    ind = marc.get_indicators( tag )
    validator = ''
    if ind && !ind.empty?
      ind.each do |(k,v)|
        v.each.each_with_object( '' )  do |(kk,vv)|
          if kk && vv
            case kk
              when /First/
                validator += vv.each_with_object( '#I' ) do |i1, str|    
                  str << indicatorize( i1 )
                end
              when /Second/
                validator += vv.each_with_object( '#J' ) do |i2, str|
                  str << indicatorize( i2 )
                end          
            end
          end
        end
      end        
    end
    validator.sub( /(.)#/, '\1 #' )
  end
  
  def validate( tag, description )
    return '' if description && description.match( /\[OBSOLETE\]/ ) 
    repeatable = description && description.match( '\(NR\)' ) ? '' : '.'
    ( '#' + tag.to_s + repeatable + ' ' + '"' + (description ? description.downcase.titlecase.strip : '' ) + '"' + ' ' + validate_indicators( tag ) + ' ' + validate_subfields( tag ) + ' ;' ).gsub( /\s+/, ' ' )
  end
  
  def indicatorize( line )
    ind, description = line.sub( '#', '_' ).split( ' - ' )
    ind = (ind[0]..ind[2]).to_a.join if ind.match('-')
    ind
  end
  
end

f = Falcon.new
# pp f.marc.marc.count
puts f.generate_validation_params
# pp f.validate_subfields( '010' )
# pp f.validate_indicators( '245' )
