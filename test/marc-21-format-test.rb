require 'minitest/autorun'
require 'marc-21-format'

class TestMARC21Format < Minitest::Test
  
  def setup
    begin
      @marc = MARC21Format.new
    rescue Exception => e
      @marc = MARC21Format.new( './documentation/marc21.txt' )
    end
  end

  def test_load_format_live_from_web
    assert marc = MARC21Format.new
    assert marc.respond_to? 'marc'
    assert_instance_of Hash, marc.marc
  end

  def test_load_format_from_file
    assert marc = MARC21Format.new( './documentation/marc21.txt'  )
    assert marc.respond_to? 'marc'
    assert_instance_of Hash, marc.marc
  end
  
  def test_get_tags_with_indicators
    assert_instance_of Hash, @marc.get_tags_with_indicators
  end
  
  def test_get_tags_without_indicators
    assert_instance_of Hash, @marc.get_tags_without_indicators
  end 

  def test_get_defined_indicators
    assert_instance_of Hash, @marc.get_defined_indicators
  end
  
  def test_get_undefined_indicators
    assert_instance_of Hash, @marc.get_undefined_indicators
  end
  
  def test_get_indicators
    assert_instance_of Hash, @marc.get_indicators( '856' )    
  end
  
  def test_get_indicators_if_no_indicators
    assert_instance_of Hash, @marc.get_indicators( '001' )
    assert @marc.get_indicators( '001' ).empty?
  end
  
  def test_get_subfields
    assert_instance_of Hash, @marc.get_subfields( '856' )
  end
  
  def test_get_subfields_if_no_subfields
    assert_instance_of Hash, @marc.get_subfields( '001' )  
    assert @marc.get_subfields( '001' ).empty?
  end
  
  def test_get_single_subfield_that_exist
    assert_instance_of String, @marc.get_subfield( '856$b' )
  end
  
  def test_get_single_subfield_that_does_not_exist
    assert_equal '', @marc.get_subfield( '856$7' )
  end
  
  def test_subfield_repeatable_true
    assert @marc.subfield_repeatable?( '856$b' ) 
  end
  
  def test_subfield_repeatable_false
    assert !@marc.subfield_repeatable?( '856$h' )
  end
  
  def subfield_repeatable_non_existant
    assert_nil @marc.subfield_repeatable?( '856$7' )
  end
  
  def test_get_single_indicator
    assert_instance_of String, @marc.get_indicator( '856i1=4' )
  end
  
  def test_find
    assert_instance_of Hash, @marc.find( 'nonfiling' )
  end

end




__END__
LEADER
     Character Positions
     00-04 - Logical record length
     05 - Record status
         a - Increase in encoding level
         c - Corrected or revised
         d - Deleted
         n - New
         p - Increase in encoding level from prepublication
     06 - Type of record
         a - Language material
         b - Archival and manuscripts control [OBSOLETE]
         c - Notated music
         d - Manuscript notated music
         e - Cartographic material
         f - Manuscript cartographic material
         g - Projected medium
         h - Microform publications [OBSOLETE]
         i - Nonmusical sound recording
         j - Musical sound recording
         k - Two-dimensional nonprojectable graphic
         m - Computer file
         n - Special instructional material [OBSOLETE]
         o - Kit
         p - Mixed material
         r - Three-dimensional artifact or naturally occurring object
         t - Manuscript language material
     07 - Bibliographic level
         a - Monographic component part
         b - Serial component part
         c - Collection
         d - Subunit
         i - Integrating resource
         m - Monograph/item
         s - Serial
     08 - Type of control
         # - No specific type
         a - Archival
     09 - Character coding scheme
         # - MARC-8
         a - UCS/Unicode
     10 - Indicator count
     11 - Subfield code count
     12-16 - Base address of data
     17 - Encoding level
         # - Full level
         1 - Full level, material not examined
         2 - Less-than-full level, material not examined
         3 - Abbreviated level
         4 - Core level
         5 - Partial (preliminary) level
         7 - Minimal level
         8 - Prepublication level
         u - Unknown
         z - Not applicable
     18 - Descriptive cataloging form
         # - Non-ISBD
         a - AACR 2
         c - ISBD punctuation omitted
         i - ISBD punctuation included
         n - Non-ISBD punctuation omitted
         p - Partial ISBD (BK) [OBSOLETE]
         r - Provisional (VM MP MU) [OBSOLETE]
         u - Unknown
     19 - Multipart resource record level
         # - Not specified or not applicable
         a - Set
         b - Part with independent title
         c - Part with dependent title 
     20-23 - Entry map
     20 - Length of the length-of-field portion
     21 - Length of the starting-character-position portion
     22 - Length of the implementation-defined portion
     23 - Undefined Entry map character position

   DIRECTORY
   Character Positions
      00-02 - Tag
      03-06 - Field length
      07-11 - Starting character position


--Control Fields (001-006)--
001 - CONTROL NUMBER (NR)

003 - CONTROL NUMBER IDENTIFIER (NR)

005 - DATE AND TIME OF LATEST TRANSACTION (NR)

006 - FIXED-LENGTH DATA ELEMENTS--ADDITIONAL MATERIAL CHARACTERISTICS--GENERAL INFORMATION (R)
  006--BOOKS
    Character Positions
     00 - Form of material
        a - Language material
        t - Manuscript language material
     01-04 - Illustrations
     05 - Target audience
     06 - Form of item
     07-10 - Nature of contents
     11 - Government publication
     12 - Conference publication
     13 - Festschrift
     14 - Index
     15 - Undefined
     16 - Literary form
     17 - Biography
  006--COMPUTER FILES/ELECTRONIC RESOURCES
    Character Positions
     00 - Form of material
        m - Computer file/Electronic resource
     01-04 - Undefined
     05 - Target audience
     06 - Form of item
     07-08 - Undefined
     09 - Type of computer file
     10 - Undefined
     11 - Government publication
     12-17 - Undefined
  006--MAPS
    Character Positions
     00 - Form of material
        e - Cartographic material
        f - Manuscript cartographic material
     01-04 - Relief
     05-06 - Projection
     07 - Undefined
     07 - Prime meridian [OBSOLETE]
     08 - Type of cartographic material
     09-10 - Undefined
     11 - Government publication
     12 - Form of item
     12 - Undefined [OBSOLETE]
     13 - Undefined
     14 - Index
     15 - Undefined
     16-17 - Special format characteristics
  006--MIXED MATERIALS
    Character Positions
     00 - Form of material
        p - Mixed material
     01-05 - Undefined
     06 - Form of item
     07-17 - Undefined
  006--MUSIC
    Character Positions
     00 - Form of material
        c - Notated music
        d - Manuscript notated music
        i - Nonmusical sound recording
        j - Musical sound recording
     01-02 - Form of composition
     03 - Format of music
     04 - Music parts
     05 - Target audience
     06 - Form of item
     07-12 - Accompanying matter
     13-14 - Literary text for sound recordings
     15 - Undefined
     16 - Transposition and arrangement
     17 - Undefined
  006--CONTINUING RESOURCES
    Character Positions
     00 - Form of material
        s - Serial/Integrating resource
     01 - Frequency
     02 - Regularity
     03 - ISSN Center [OBSOLETE]
     04 - Type of continuing resource
     05 - Form of original item
     06 - Form of item
     07 - Nature of entire work
     08-10 - Nature of contents
     11 - Government publication
     12 - Conference publication
     13-15 - Undefined
     16 - Original alphabet or script of title
     17 - Entry convention
  006--VISUAL MATERIALS
    Character Positions
     00 - Form of material
        g - Projected medium
        k - Two-dimensional nonprojectable graphic
        o - Kit
        r - Three-dimensional artifact or naturally occurring object
     01-03 - Running time
     04 - Undefined
     05 - Target audience
     06-10 - Undefined
     06-10 - Accompanying matter [OBSOLETE]
     11 - Government publication
     12 - Form of item
     12 - Undefined [OBSOLETE]
     13-15 - Undefined
     16 - Type of visual material
     17 - Technique
	 
--Control Field 007--
007 - PHYSICAL DESCRIPTION FIXED FIELD--GENERAL INFORMATION (R)
   007--MAP
    Character Positions
      00 - Category of material
         a - Map
      01 - Specific material designation
         d - Atlas
         g - Diagram
         j - Map
         k - Profile
         q - Model
         r - Remote-sensing image
         s - Section
         u - Unspecified
         y - View
         z - Other
         | - No attempt to code
      02 - Undefined
      03 - Color
         a - One color
         c - Multicolored
         | - No attempt to code
      04 - Physical medium
         a - Paper
         b - Wood
         c - Stone
         d - Metal
         e - Synthetic
         f - Skin
         g - Textile
         i - Plastic
         j - Glass
         l - Vinyl
         n - Vellum
         p - Plaster
         q - Flexible base photographic, positive
         r - Flexible base photographic, negative
         s - Non-flexible base photographic, positive
         t - Non-flexible base photographic, negative
         u - Unknown
         v - Leather
         w - Parchment
         y - Other photographic medium
         z - Other
         | - No attempt to code
      05 - Type of reproduction
         f - Facsimile
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      06 - Production/reproduction details
         a - Photocopy, blueline print
         b - Photocopy
         c - Pre-production
         d - Film
         u - Unknown
         z - Other
         | - No attempt to code
      07 - Positive/negative aspect
         a - Positive
         b - Negative
         m - Mixed polarity
         n - Not applicable
         | - No attempt to code
   007--ELECTRONIC RESOURCE
     Character Positions
      00 - Category of material
         c - Computer file
      01 - Specific material designation
         a - Tape cartridge
         b - Chip cartridge
         c - Computer optical disc cartridge
         d - Computer disc, type unspecified
         e - Computer disc cartridge, type unspecified
         f - Tape cassette
         h - Tape reel
         j - Magnetic disk
         k - Computer card
         m - Magneto-optical disc
         o - Optical disc
         r - Remote
         s - Standalone device
         u - Unspecified
         z - Other
         | - No attempt to code
      02 - Undefined
      03 - Color
         a - One color
         b - Black-and-white
         c - Multicolored
         g - Gray scale
         m - Mixed
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      04 - Dimensions
         a - 3 1/2 in.
         e - 12 in.
         g - 4 3/4 in. or 12 cm.
         i - 1 1/8 x 2 3/8 in.
         j - 3 7/8 x 2 1/2 in.
         n - Not applicable
         o - 5 1/4 in.
         u - Unknown
         v - 8 in.
         z - Other
         | - No attempt to code
      05 - Sound
         # - No sound (silent)
         a - Sound on medium
         u - Unknown
         | - No attempt to code
      06-08 - Image bit depth
         001-999 - Exact bit depth
         mmm - Multiple
         nnn - Not applicable
         --- - Unknown
         ||| - No attempt to code
      09 - File formats
         a - One
         m - Multiple
         u - Unknown
         | - No attempt to code
      10 - Quality assurance target(s)
         a - Absent
         n - Not applicable
         p - Present
         u - Unknown
         | - No attempt to code
      11 - Antecedent/source
         a - File reproduced from original
         b - File reproduced from microform
         c - File reproduced from an electronic resource
         d - File reproduced from an intermediate (not microform)
         m - Mixed
         n - Not applicable
         u - Unknown
         | - No attempt to code
      12 - Level of compression
         a - Uncompressed
         b - Lossless
         d - Lossy
         m - Mixed
         u - Unknown
         | - No attempt to code
      13 - Reformatting quality
         a - Access
         n - Not applicable
         p - Preservation
         r - Replacement
         u - Unknown
         | - No attempt to code
   007--GLOBE
     Character Positions
      00 - Category of material
         d - Globe
      01 - Specific material designation
         a - Celestial globe
         b - Planetary or lunar globe
         c - Terrestrial globe
         e - Earth moon globe
         u - Unspecified
         z - Other
         | - No attempt to code
      02 - Undefined
      03 - Color
         a - One color
         c - Multicolored
         | - No attempt to code
      04 - Physical medium
         a - Paper
         b - Wood
         c - Stone
         d - Metal
         e - Synthetic
         f - Skin
         g - Textile
         i - Plastic
         l - Vinyl
         n - Vellum
         p - Plaster
         u - Unknown
         v - Leather
         w - Parchment
         z - Other
         | - No attempt to code
      05 - Type of reproduction
         f - Facsimile
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
   007--TACTILE MATERIAL
     Character Positions
      00 - Category of material
         f - Tactile material
      01 - Specific material designation
         a - Moon
         b - Braille
         c - Combination
         d - Tactile, with no writing system
         u - Unspecified
         z - Other
         | - No attempt to code
      02 - Undefined
      03-04 - Class of braille writing
         # - No specified class of braille writing
         a - Literary braille
         b - Format code braille
         c - Mathematics and scientific braille
         d - Computer braille
         e - Music braille
         m - Multiple braille types
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      05 - Level of contraction
         a - Uncontracted
         b - Contracted
         m - Combination
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      06-08 - Braille music format
         # - No specified braille music format
         a - Bar over bar
         b - Bar by bar
         c - Line over line
         d - Paragraph
         e - Single line
         f - Section by section
         g - Line by line
         h - Open score
         i - Spanner short form scoring
         j - Short form scoring
         k - Outline
         l - Vertical score
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      09 - Specific physical characteristics
         a - Print/braille
         b - Jumbo or enlarged braille
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
   007--PROJECTED GRAPHIC
     Character Positions
      00 - Category of material
         g - Projected graphic
      01 - Specific material designation
         c - Filmstrip cartridge
         d - Filmslip
         f - Filmstrip, type unspecified
         o - Filmstrip roll
         s - Slide
         t - Transparency
         u - Unspecified
         z - Other
         | - No attempt to code
      02 - Undefined
      03 - Color
         a - One color
         b - Black-and-white
         c - Multicolored
         h - Hand colored
         m - Mixed
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      04 - Base of emulsion
         d - Glass
         e - Synthetic
         j - Safety film
         k - Film base, other than safety film
         m - Mixed collection
         o - Paper
         u - Unknown
         z - Other
         | - No attempt to code
      05 - Sound on medium or separate
         # - No sound (silent)
         a - Sound on medium
         b - Sound separate from medium
         u - Unknown
         | - No attempt to code
      06 - Medium for sound
         # - No sound (silent)
         a - Optical sound track on motion picture film
         b - Magnetic sound track on motion picture film
         c - Magnetic audio tape in cartridge
         d - Sound disc
         e - Magnetic audio tape on reel
         f - Magnetic audio tape in cassette
         g - Optical and magnetic sound track on motion picture film
         h - Videotape
         i - Videodisc
         u - Unknown
         z - Other
         | - No attempt to code
      07 - Dimensions
         a - Standard 8 mm.
         b - Super 8 mm./single 8 mm.
         c - 9.5 mm.
         d - 16 mm.
         e - 28 mm.
         f - 35 mm.
         g - 70 mm.
         j - 2x2 in. or 5x5 cm.
         k - 2 1/4 x 2 1/4 in. or 6x6 cm.
         s - 4x5 in. or 10x13 cm.
         t - 5x7 in. or 13x18 cm.
         u - Unknown
         v - 8x10 in. or 21x26 cm.
         w - 9x9 in. or 23x23 cm.
         x - 10x10 in. or 26x26 cm.
         y - 7x7 in. or 18x18 cm.
         z - Other
         | - No attempt to code
      08 - Secondary support material
         # - No secondary support
         c - Cardboard
         d - Glass
         e - Synthetic
         h - Metal
         j - Metal and glass
         k - Synthetic and glass
         m - Mixed collection
         u - Unknown
         z - Other
         | - No attempt to code
   007--MICROFORM
     Character Positions
      00 - Category of material
         h - Microform
      01 - Specific material designation
         a - Aperture card
         b - Microfilm cartridge
         c - Microfilm cassette
         d - Microfilm reel
         e - Microfiche
         f - Microfiche cassette
         g - Microopaque
         h - Microfilm slip
         j - Mircrofilm roll
         u - Unspecified
         z - Other
         | - No attempt to code
      02 - Undefined
      03 - Positive/negative aspect
         a - Positive
         b - Negative
         m - Mixed polarity
         u - Unknown
         | - No attempt to code
      04 - Dimensions
         a - 8 mm.
         d - 16 mm.
         f - 35 mm.
         g - 70 mm.
         h - 105 mm.
         l - 3x5 in. or 8x13 cm.
         m - 4x6 in. or 11x15 cm.
         o - 6x9 in. or 16x23 cm.
         p - 3 1/4 x 7 3/8 in. or 9x19 cm.
         u - Unknown
         z - Other
         | - No attempt to code
      05 - Reduction ratio range
         a - Low reduction
         b - Normal reduction
         c - High reduction
         d - Very high reduction
         e - Ultra high reduction
         u - Unknown
         v - Reduction rate varies
         | - No attempt to code
      06-08 - Reduction ratio
      09 - Color
         b - Black-and-white (or monochrome)
         c - Multicolored
         m - Mixed
         u - Unknown
         z - Other
         | - No attempt to code
      10 - Emulsion on film
         a - Silver halide
         b - Diazo
         c - Vesicular
         m - Mixed emulsion
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      11 - Generation
         a - First generation (master)
         b - Printing master
         c - Service copy
         m - Mixed generation
         u - Unknown
         | - No attempt to code
      12 - Base of film
         a - Safety base, undetermined
         c - Safety base, acetate undetermined
         d - Safety base, diacetate
         p - Safety base, polyester
         r - Safety base, mixed
         t - Safety base, triacetate
         i - Nitrate base
         m - Mixed base (nitrate and safety)
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
   007--NONPROJECTED GRAPHIC
     Character Positions
      00 - Category of material
         k - Nonprojected graphic
      01 - Specific material designation
         a - Activity card
         c - Collage
         d - Drawing
         e - Painting
         f - Photomechanical print
         g - Photonegative
         h - Photoprint
         i - Picture
         j - Print
         k - Poster
         l - Technical drawing
         n - Chart
         o - Flash card
         p - Postcard
         q - Icon
         r - Radiograph
         s - Study print
         u - Unspecified
         v - Photograph, type unspecified
         z - Other
         | - No attempt to code
      02 - Undefined
      03 - Color
         a - One color
         b - Black-and-white
         c - Multicolored
         h - Hand colored
         m - Mixed
         u - Unknown
         z - Other
         | - No attempt to code
      04 - Primary support material
         a - Canvas
         b - Bristol board
         c - Cardboard/illustration board
         d - Glass
         e - Synthetic
         f - Skin
         g - Textile
         h - Metal
         i - Plastic
         l - Vinyl
         m - Mixed collection
         n - Vellum
         o - Paper
         p - Plaster
         q - Hardboard
         r - Porcelain
         s - Stone
         t - Wood
         u - Unknown
         v - Leather
         w - Parchment
         z - Other
         | - No attempt to code
      05 - Secondary support material
         # - No secondary support
         a - Canvas
         b - Bristol board
         c - Cardboard/illustration board
         d - Glass
         e - Synthetic
         f - Skin
         g - Textile
         h - Metal
         i - Plastic
         l - Vinyl
         m - Mixed collection
         n - Vellum
         o - Paper
         p - Plaster
         q - Hardboard
         r - Porcelain
         s - Stone
         t - Wood
         u - Unknown
         v - Leather
         w - Parchment
         z - Other
         | - No attempt to code
   007--MOTION PICTURE
     Character Positions
      00 - Category of material
         m - Motion picture
      01 - Specific material designation
         c - Film cartridge
         f - Film cassette
         o - Film roll
         r - Film reel
         u - Unspecified
         z - Other
         | - No attempt to code
      02 - Undefined
      03 - Color
         b - Black-and-white
         c - Multicolored
         h - Hand colored
         m - Mixed
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      04 - Motion picture presentation format
         a - Standard sound aperture (reduced frame)
         b - Nonanamorphic (wide-screen)
         c - 3D
         d - Anamorphic (wide-screen)
         e - Other wide-screen format
         f - Standard silent aperture (full frame)
         u - Unknown
         z - Other
         | - No attempt to code
      05 - Sound on medium or separate
         # - No sound (silent)
         a - Sound on medium
         b - Sound separate from medium
         u - Unknown
         | - No attempt to code
      06 - Medium for sound
         # - No sound (silent)
         a - Optical sound track on motion picture film
         b - Magnetic sound track on motion picture film
         c - Magnetic audio tape in cartridge
         d - Sound disc
         e - Magnetic audio tape on reel
         f - Magnetic audio tape in cassette
         g - Optical and magnetic sound track on motion picture film
         h - Videotape
         i - Videodisc
         u - Unknown
         z - Other
         | - No attempt to code
      07 - Dimensions
         a - Standard 8 mm.
         b - Super 8 mm./single 8 mm.
         c - 9.5 mm.
         d - 16 mm.
         e - 28 mm.
         f - 35 mm.
         g - 70 mm.
         u - Unknown
         z - Other
         | - No attempt to code
      08 - Configuration of playback channels
         k - Mixed
         m - Monaural
         n - Not applicable
         q - Quadraphonic, multichannel, or surround
         s - Stereophonic
         u - Unknown
         z - Other
         | - No attempt to code
      09 - Production elements
         a - Workprint
         b - Trims
         c - Outtakes
         d - Rushes
         e - Mixing tracks
         f - Title bands/intertitle rolls
         g - Production rolls
         n - Not applicable
         z - Other
         | - No attempt to code
      10 - Positive/negative aspect
         a - Positive
         b - Negative
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      11 - Generation
         d - Duplicate
         e - Master
         o - Original
         r - Reference print/viewing copy
         u - Unknown
         z - Other
         | - No attempt to code
      12 - Base of film
         a - Safety base, undetermined
         c - Safety base, acetate undetermined
         d - Safety base, diacetate
         p - Safety base, polyester
         r - Safety base, mixed
         t - Safety base, triacetate
         i - Nitrate base
         m - Mixed base (nitrate and safety)
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      13 - Refined categories of color
         a - 3 layer color
         b - 2 color, single strip
         c - Undetermined 2 color
         d - Undetermined 3 color
         e - 3 strip color
         f - 2 strip color
         g - Red strip
         h - Blue or green strip
         i - Cyan strip
         j - Magenta strip
         k - Yellow strip
         l - S E N 2
         m - S E N 3
         n - Not applicable
         p - Sepia tone
         q - Other tone
         r - Tint
         s - Tinted and toned
         t - Stencil color
         u - Unknown
         v - Hand colored
         z - Other
         | - No attempt to code
      14 - Kind of color stock or print
         a - Imbibition dye transfer prints
         b - Three layer stock
         c - Three layer stock, low fade
         d - Duplitized stock
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      15 - Deterioration stage
         a - None apparent
         b - Nitrate: suspicious odor
         c - Nitrate: pungent odor
         d - Nitrate: brownish, discoloration, fading, dusty
         e - Nitrate: sticky
         f - Nitrate: frothy, bubbles, blisters
         g - Nitrate: congealed
         h - Nitrate: powder
         k - Non-nitrate: detectable deterioration (diacetate odor)
         l - Non-nitrate: advanced deterioration
         m - Non-nitrate: disaster
         | - No attempt to code
      16 - Completeness
         c - Complete
         i - Incomplete
         n - Not applicable
         u - Unknown
         | - No attempt to code
      17-22 - Film inspection date
   007--KIT
     Character Positions
      00 - Category of material
         o - Kit
      01 - Specific material designation
         u - Unspecified
         | - No attempt to code
   007--NOTATED MUSIC
     Character Positions
      00 - Category of material
         q - Notated music
      01 - Specific material designation
         u - Unspecified
         | - No attempt to code
   007--REMOTE-SENSING IMAGE
     Character Positions
      00 - Category of material
         r - Remote-sensing image
      01 - Specific material designation
         u - Unspecified
         | - No attempt to code
      02 - Undefined
      03 - Altitude of sensor
         a - Surface
         b - Airborne
         c - Spaceborne
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      04 - Attitude of sensor
         a - Low oblique
         b - High oblique
         c - Vertical
         n - Not applicable
         u - Unknown
         | - No attempt to code
      05 - Cloud cover
         0 - 0-9%
         1 - 10-19%
         2 - 20-29%
         3 - 30-39%
         4 - 40-49%
         5 - 50-59%
         6 - 60-69%
         7 - 70-79%
         8 - 80-89%
         9 - 90-100%
         n - Not applicable
         u - Unknown
         | - No attempt to code
      06 - Platform construction type
         a - Balloon
         b - Aircraft--low altitude
         c - Aircraft--medium altitude
         d - Aircraft--high altitude
         e - Manned spacecraft
         f - Unmanned spacecraft
         g - Land-based remote-sensing device
         h - Water surface-based remote-sensing device
         i - Submersible remote-sensing device
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      07 - Platform use category
         a - Meteorological
         b - Surface observing
         c - Space observing
         m - Mixed uses
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      08 - Sensor type
         a - Active
         b - Passive
         u - Unknown
         z - Other
         | - No attempt to code
      09-10 - Data type
         aa - Visible light
         da - Near infrared
         db - Middle infrared
         dc - Far infrared
         dd - Thermal infrared
         de - Shortwave infrared (SWIR)
         df - Reflective infrared
         dv - Combinations
         dz - Other infrared data
         ga - Sidelooking airborne radar (SLAR)
         gb - Synthetic aperture radar (SAR)-Single frequency
         gc - SAR-multi-frequency (multichannel)
         gd - SAR-like polarization
         ge - SAR-cross polarization
         gf - Infometric SAR
         gg - polarmetric SAR
         gu - Passive microwave mapping
         gz - Other microwave data
         ja - Far ultraviolet
         jb - Middle ultraviolet
         jc - Near ultraviolet
         jv - Ultraviolet combinations
         jz - Other ultraviolet data
         ma - Multi-spectral, multidata
         mb - Multi-temporal
         mm - Combination of various data types
         nn - Not applicable
         pa - Sonar--water depth
         pb - Sonar--bottom topography images, sidescan
         pc - Sonar--bottom topography, near surface
         pd - Sonar--bottom topography, near bottom
         pe - Seismic surveys
         pz - Other acoustical data
         ra - Gravity anomalies (general)
         rb - Free-air
         rc - Bouger
         rd - Isostatic
         sa - Magnetic field
         ta - radiometric surveys
         uu - Unknown
         zz - Other
         || - No attempt to code
   007--SOUND RECORDING
     Character Positions
      00 - Category of material
         s - Sound recording
      01 - Specific material designation
         d - Sound disc
         e - Cylinder
         g - Sound cartridge
         i - Sound-track film
         q - Roll
         r - Remote
         s - Sound cassette
         t - Sound-tape reel
         u - Unspecified
         w - Wire recording
         z - Other
         | - No attempt to code
      02 - Undefined
      03 - Speed
         a - 16 rpm
         b - 33 1/3 rpm
         c - 45 rpm
         d - 78 rpm
         e - 8 rpm
         f - 1.4 m. per sec.
         h - 120 rpm
         i - 160 rpm
         k - 15/16 ips
         l - 1 7/8 ips
         m - 3 3/4 ips
         n - Not applicable
         o - 7 1/2 ips
         p - 15 ips
         r - 30 ips
         u - Unknown
         z - Other
         | - No attempt to code
      04 - Configuration of playback channels
         m - Monaural
         q - Quadraphonic, multichannel, or surround
         s - Stereophonic
         u - Unknown
         z - Other
         | - No attempt to code
      05 - Groove width/groove pitch
         m - Microgroove/fine
         n - Not applicable
         s - Coarse/standard
         u - Unknown
         z - Other
         | - No attempt to code
      06 - Dimensions
         a - 3 in.
         b - 5 in.
         c - 7 in.
         d - 10 in.
         e - 12 in.
         f - 16 in.
         g - 4 3/4 in. or 12 cm.
         j - 3 7/8 x 2 1/2 in.
         o - 5 1/4 x 3 7/8 in.
         n - Not applicable
         s - 2 3/4 x 4 in.
         u - Unknown
         z - Other
         | - No attempt to code
      07 - Tape width
         l - 1/8 in.
         m - 1/4 in.
         n - Not applicable
         o - 1/2 in.
         p - 1 in.
         u - Unknown
         z - Other
         | - No attempt to code
      08 - Tape configuration
         a - Full (1) track
         b - Half (2) track
         c - Quarter (4) track
         d - Eight track
         e - Twelve track
         f - Sixteen track
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      09 - Kind of disc, cylinder or tape
         a - Master tape
         b - Tape duplication master
         d - Disc master (negative)
         i - Instantaneous (recorded on the spot)
         m - Mass produced
         n - Not applicable
         r - Mother (positive)
         s - Stamper (negative)
         t - Test pressing
         u - Unknown
         z - Other
         | - No attempt to code
      10 - Kind of material
         a - Lacquer coating
         b - Cellulose nitrate
         c - Acetate tape with ferrous oxide
         g - Glass with lacquer
         i - Aluminum with lacquer
         r - Paper with lacquer or ferrous oxide
         l - Metal
         m - Plastic with metal
         n - Not applicable
         p - Plastic
         s - Shellac
         u - Unknown
         w - Wax
         z - Other
         | - No attempt to code
      11 - Kind of cutting
         h - Hill-and-dale cutting
         l - Lateral or combined cutting
         n - Not applicable
         u - Unknown
         | - No attempt to code
      12 - Special playback characteristics
         a - NAB standard
         b - CCIR standard
         c - Dolby-B encoded
         d - dbx encoded
         e - Digital recording
         f - Dolby-A encoded
         g - Dolby-C encoded
         h - CX encoded
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      13 - Capture and storage technique
         a - Acoustical capture, direct storage
         b - Direct storage, not acoustical
         d - Digital storage
         e - Analog electrical storage
         u - Unknown
         z - Other
         | - No attempt to code
   007--TEXT
     Character Positions
      00 - Category of material
         t - Text
      01 - Specific material designation
         a - Regular print
         b - Large print
         c - Braille
         d - Text in looseleaf binder
         u - Unspecified
         z - Other
         | - No attempt to code
   007--VIDEORECORDING
     Character Positions
      00 - Category of material
         v - Videorecording
      01 - Specific material designation
         c - Videocartridge
         d - Videodisc
         f - Videocassette
         r - Videoreel
         u - Unspecified
         z - Other
         | - No attempt to code
      02 - Undefined
      03 - Color
         a - One color
         b - Black-and-white
         c - Multicolored
         m - Mixed
         n - Not applicable
         u - Unknown
         z - Other
         | - No attempt to code
      04 - Videorecording format
         a - Beta (1/2 in., videocassette)
         b - VHS (1/2 in., videocassette)
         c - U-matic (3/4 in., videocassette)
         d - EIAJ (1/2 in. reel)
         e - Type C (1 in., reel)
         f - Quadruplex (1 in. or 2 in., reel)
         g - Laserdisc
         h - CED (Capacitance Electronic Disc) videodisc
         i - Betacam (1/2 in., videocassette)
         j - Betacam SP (1/2 in., videocassette)
         k - Super-VHS (1/2 in., videocassette)
         m - M-II (1/2 in., videocassette)
         o - D-2 (3/4 in., videocassette)
         p - 8 mm.
         q - Hi-8 mm.
         s - Blu-ray disc
         u - Unknown
         v - DVD
         z - Other
         | - No attempt to code
      05 - Sound on medium or separate
         # - No sound (silent)
         a - Sound on medium
         b - Sound separate from medium
         u - Unknown
         |- No attempt to code
      06 - Medium for sound
         # - No sound (silent)
         a - Optical sound track on motion picture film
         b - Magnetic sound track on motion picture film
         c - Magnetic audio tape in cartridge
         d - Sound disc
         e - Magnetic audio tape on reel
         f - Magnetic audio tape in cassette
         g - Optical and magnetic sound track on motion picture film
         h - Videotape
         i - Videodisc
         u - Unknown
         z - Other
         | - No attempt to code
      07 - Dimensions
         a - 8 mm.
         m - 1/4 in.
         o - 1/2 in.
         p - 1 in.
         q - 2 in.
         r - 3/4 in.
         u - Unknown
         z - Other
         | - No attempt to code
      08 - Configuration of playback channels
         k - Mixed
         m - Monaural
         n - Not applicable
         q - Quadraphonic, multichannel, or surround
         s - Stereophonic
         u - Unknown
         z - Other
         | - No attempt to code
   007--UNSPECIFIED
     Character Positions
      00 - Category of material
         z - Unspecified
      01 - Specific material designation
         m - Multiple physical forms
         u - Unspecified
         z - Other
         | - No attempt to code

--Control Field 008--
008 - FIXED-LENGTH DATA ELEMENTS--GENERAL INFORMATION (NR)
  008--ALL MATERIALS
    Character Positions
      00-05 - Date entered on file
      06 - Type of date/Publication status
         b - No dates given; B.C. date involved
         c - Continuing resource currently published
         c - Actual date and copyright date [OBSOLETE]
         d - Continuing resource ceased publication
         d - Detailed date [OBSOLETE]
         e - Detailed date
         i - Inclusive dates of collection
         k - Range of years of bulk of collection
         m - Multiple dates
         n - Dates unknown
         p - Date of distribution/release/issue and production/recording session when different
         q - Questionable date
         r - Reprint/reissue date and original date
         s - Single known date/probable date
         t - Publication date and copyright date
         u - Continuing resource status unknown
         | - No attempt to code
      07-10 - Date 1
         1-9 - Date digit
         # - Date element is not applicable
         u - Date element is totally or partially unknown
         | - No attempt to code
      11-14 - Date 2
         1-9 - Date digit
         # - Date element is not applicable
         u - Date element is totally or partially unknown
         | - No attempt to code
      15-17 - Place of publication, production, or execution
      35-37 - Language
      38 - Modified record
         # - Not modified
         d - Dashed-on information omitted
         o - Completely romanized/printed cards romanized
         r - Completely romanized/printed cards in script
         s - Shortened
         x - Missing characters
         | - No attempt to code
      39 - Cataloging source
         # - National bibliographic agency
         a - National Agricultural Library [OBSOLETE]
         b - National Library of Medicine [OBSOLETE]
         c - Cooperative cataloging program
         d - Other
         n - Report to [OBSOLETE]
         u - Unknown
         | - No attempt to code
   008--BOOKS
     Character Positions
      18-21 - Illustrations
         # - No illustrations
         a - Illustrations
         b - Maps
         c - Portraits
         d - Charts
         e - Plans
         f - Plates
         g - Music
         h - Facsimiles
         i - Coats of arms
         j - Genealogical tables
         k - Forms
         l - Samples
         m - Phonodisc, phonowire, etc.
         o - Photographs
         p - Illuminations
         | - No attempt to code
      22 - Target audience
         # - Unknown or not specified
         a - Preschool
         b - Primary
         c - Pre-adolescent
         d - Adolescent
         e - Adult
         f - Specialized
         g - General
         j - Juvenile
         | - No attempt to code
      23 - Form of item
         # - None of the following
         a - Microfilm
         b - Microfiche
         c - Microopaque
         d - Large print
         f - Braille
         g - Punched paper tape [OBSOLETE]
         h - Magnetic tape [OBSOLETE]
         i - Multimedia [OBSOLETE]
         o - Online
         q - Direct electronic
         r - Regular print reproduction
         s - Electronic
         z - Other form of reproduction [OBSOLETE]
         | - No attempt to code
      24-27 - Nature of contents
         # - No specified nature of contents
         a - Abstracts/summaries
         b - Bibliographies
         c - Catalogs
         d - Dictionaries
         e - Encyclopedias
         f - Handbooks
         g - Legal articles
         h - Handbooks [OBSOLETE]
         i - Indexes
         j - Patent document
         k - Discographies
         l - Legislation
         m - Theses
         n - Surveys of literature in a subject area
         o - Reviews
         p - Programmed texts
         q - Filmographies
         r - Directories
         s - Statistics
         t - Technical reports
         u - Standards/specifications
         v - Legal cases and case notes
         w - Law reports and digests
         x - Technical reports [OBSOLETE]
         y - Yearbooks
         z - Treaties
         2 - Offprints
         5 - Calendars
         6 - Comics/graphic novels
         | - No attempt to code
      28 - Government publication
         # - Not a government publication
         a - Autonomous or semi-autonomous component
         c - Multilocal
         f - Federal/national
         i - International intergovernmental
         l - Local
         m - Multistate
         n - Government publication--level undetermined [OBSOLETE]
         o - Government publication--level undetermined
         s - State, provincial, territorial, dependent, etc.
         u - Unknown if item is government publication
         z - Other
         | - No attempt to code
      29 - Conference publication
         0 - Not a conference publication
         1 - Conference publication
         | - No attempt to code
      30 - Festschrift
         0 - Not a festschrift
         1 - Festschrift
         | - No attempt to code
      31 - Index
         0 - No index
         1 - Index present
         | - No attempt to code
      32 - Undefined
      32 - Main entry in body of entry [OBSOLETE]
         0 - Main entry not in body of entry
         1 - Main entry in body of entry
         | - No attempt to code
      33 - Literary form
         0 - Not fiction (not further specified)
         1 - Fiction (not further specified)
         c - Comic strips [OBSOLETE]
         d - Dramas
         e - Essays
         f - Novels
         h - Humor, satires, etc.
         i - Letters
         j - Short stories
         m - Mixed forms
         p - Poetry
         s - Speeches
         u - Unknown
         | - No attempt to code
      34 - Biography
         # - No biographical material
         a - Autobiography
         b - Individual biography
         c - Collective biography
         d - Contains biographical information
         | - No attempt to code
  008--COMPUTER FILES
    Character Positions
      18-21 - Undefined
      18 - Frequency [OBSOLETE]
         # - No determinable frequency
         a - Annual
         b - Bimonthly
         c - Semiweekly
         d - Daily
         e - Biweekly
         f - Semiannual
         g - Biennial
         h - Triennial
         i - Three times a week
         j - Three times a month
         m - Monthly
         n - Not applicable
         q - Quarterly
         s - Semimonthly
         t - Three times a year
         u - Unknown
         w - Weekly
         z - Other frequencies
      19 - Regularity [OBSOLETE]
         # - Not applicable
         n - Normalized irregular
         r - Regular
         u - Unknown
         x - Completely irregular
      22 - Target audience
         # - Unknown or not specified
         a - Preschool
         b - Primary
         c - Pre-adolescent
         d - Adolescent
         e - Adult
         f - Specialized
         g - General
         j - Juvenile
         | - No attempt to code
      23 - Form of item
         o - Online
         q - Direct electronic
      24-25 - Undefined
      26 - Type of computer file
         a - Numeric data
         b - Computer program
         c - Representational
         d - Document
         e - Bibliographic data
         f - Font
         g - Game
         h - Sound
         i - Interactive multimedia
         j - Online system or service
         m - Combination
         u - Unknown
         z - Other
         | - No attempt to code
      27 - Undefined
      27 - Type of machine [OBSOLETE]
         a - Computer readable
         z - Other
      28 - Government publication
         # - Not a government publication
         a - Autonomous or semi-autonomous component
         c - Multilocal
         f - Federal/national
         i - International intergovernmental
         l - Local
         m - Multistate
         o - Government publication--level undetermined
         s - State, provincial, territorial, dependent, etc.
         u - Unknown if item is government publication
         z - Other
         | - No attempt to code
      29-34 - Undefined
  008--MAPS
    Character Positions
      18-21 - Relief
         # - No relief shown
         a - Contours
         b - Shading
         c - Gradient and bathymetric tints
         d - Hachures
         e - Bathymetry/soundings
         f - Form lines
         g - Spot heights
         h - Color [OBSOLETE]
         i - Pictorially
         j - Land forms
         k - Bathymetry/isolines
         m - Rock drawings
         z - Other relief type
         | - No attempt to code
      22-23 - Projection
         ## - Projection not specified
         aa - Aitoff
         ab - Gnomic
         ac - Lambert's azimuthal equal area
         ad - Orthographic
         ae - Azimuthal equidistant
         af - Stereographic
         ag - General vertical near-sided
         am - Modified stereographic for Alaska
         an - Chamberlin trimetric
         ap - Polar stereographic
         au - Azimuthal, specific type unknown
         az - Azimuthal, other
         ba - Gall
         bb - Goode's homolographic
         bc - Lambert's cylindrical equal area
         bd - Mercator
         be - Miller
         bf - Mollweide
         bg - Sinusoidal
         bh - Transverse Mercator
         bi - Gauss-Kruger
         bj - Equirectangular
         bk - Krovak
         bl - Cassini-Soldner
         bo - Oblique Mercator
         br - Robinson
         bs - Space oblique Mercator
         bu - Cylindrical, specific type unknown
         bz - Cylindrical, other
         ca - Alber's equal area
         cb - Bonne
         cc - Lambert's conformal conic
         ce - Equidistant conic
         cp - Polyconic
         cu - Conic, specific type unknown
         cz - Conic, other
         da - Armadillo
         db - Butterfly
         dc - Eckert
         dd - Goode's homolosine
         de - Miller's bipolar oblique conformal conic
         df - Van Der Grinten
         dg - Dimaxion
         dh - Cordiform
         dl - Lambert conformal
         zz - Other
          | - No attempt to code
      24 - Undefined
      24 - Prime meridian [OBSOLETE]
         # - Prime meridian not specified
         e - Greenwich
         f - Ferro
         g - Paris
         h - Other [OBSOLETE]
         p - Philadelphia
         w - Washington, D.C.
         z - Other
      25 - Type of cartographic material
         a - Single map
         b - Map series
         c - Map serial
         d - Globe
         e - Atlas
         f - Separate map supplement to another work
         g - Map bound as part of another work
         u - Unknown
         z - Other
         | - No attempt to code
      26-27 - Undefined
      26-27 - Publisher code [OBSOLETE]
      28 - Government publication
         # - Not a government publication
         a - Autonomous or semi-autonomous component
         c - Multilocal
         f - Federal/national
         i - International intergovernmental
         l - Local
         m - Multistate
         o - Government publication--level undetermined
         s - State, provincial, territorial, dependent, etc.
         u - Unknown if item is government publication
         z - Other
         | - No attempt to code
      29 - Form of item
         # - None of the following
         a - Microfilm
         b - Microfiche
         c - Microopaque
         d - Large print
         f - Braille
         o - Online
         q - Direct electronic
         r - Regular print reproduction
         s - Electronic
         | - No attempt to code
      30 - Undefined
      31 - Index
         0 - No index
         1 - Index present
         | - No attempt to code
      32 - Undefined
      32 - Citation indicator [OBSOLETE]
      33-34 - Special format characteristics
         # - No specified special format characteristics
         a - Photocopy, blue line print [OBSOLETE]
         b - Photocopy [OBSOLETE]
         c - Negative photocopy [OBSOLETE]
         d - Film negative [OBSOLETE]
         e - Manuscript
         f - Facsimile [OBSOLETE]
         g - Relief model [OBSOLETE]
         h - Rare [OBSOLETE]
         j - Picture card, post card
         k - Calendar
         l - Puzzle
         m - Braille [OBSOLETE]
         n - Game
         o - Wall map
         p - Playing cards
         q - Large print [OBSOLETE]
         r - Loose-leaf
         z - Other
         | - No attempt to code
  008--MUSIC
    Character Positions
      18-19 - Form of composition
         an - Anthems
         bd - Ballads
         bg - Bluegrass music
         bl - Blues
         bt - Ballets
         ca - Chaconnes
         cb - Chants, Other religions
         cc - Chant, Christian
         cg - Concerti grossi
         ch - Chorales
         cl - Chorale preludes
         cn - Canons and rounds
         co - Concertos
         cp - Chansons, polyphonic
         cr - Carols
         cs - Chance compositions
         ct - Cantatas
         cy - Country music
         cz - Canzonas
         df - Dance forms
         dv - Divertimentos, serenades, cassations, divertissements, notturni
         fg - Fugues
         fl - Flamenco
         fm - Folk music
         ft - Fantasias
         gm - Gospel music
         hy - Hymns
         jz - Jazz
         mc - Musical revues and comedies
         md - Madrigals
         mi - Minuets
         mo - Motets
         mp - Motion picture music
         mr - Marches
         ms - Masses
         mu - Multiple forms
         mz - Mazurkas
         nc - Nocturnes
         nn - Not applicable
         op - Operas
         or - Oratorios
         ov - Overtures
         pg - Program music
         pm - Passion music
         po - Polonaises
         pp - Popular music
         pr - Preludes
         ps - Passacaglias
         pt - Part-songs
         pv - Pavans
         rc - Rock music
         rd - Rondos
         rg - Ragtime music
         ri - Ricercars
         rp - Rhapsodies
         rq - Requiems
         sd - Square dance music
         sg - Songs
         sn - Sonatas
         sp - Symphonic poems
         st - Studies and exercises
         su - Suites
         sy - Symphonies
         tc - Toccatas
         tl - Teatro lirico
         ts - Trio-sonatas
         uu - Unknown
         vi - Villancicos 
         vr - Variations
         wz - Waltzes
         za - Zarzuelas
         zz - Other
         || - No attempt to code
      20 - Format of music
         a - Full score
         b - Miniature or study score
         c - Accompaniment reduced for keyboard
         d - Voice score with accompaniment omitted
         e - Condensed score or piano-conductor score
         g - Close score
         h - Chorus score
         i - Condensed score
         j - Performer-conductor part
         k - Vocal score
         l - Score
         m - Multiple score formats
         n - Not applicable
         p - Piano score
         u - Unknown
         z - Other
         | - No attempt to code
      21 - Music parts
         # - No parts in hand or not specified
         d - Instrumental and vocal parts
         e - Instrumental parts
         f - Vocal parts
         n - Not applicable
         u - Unknown
         | - No attempt to code
      21 - Existence of parts [OBSOLETE]
         # - No parts exist
         a - Parts exist
         n - Not applicable
         u - Unknown
      22 - Target audience
         # - Unknown or not specified
         a - Preschool
         b - Primary
         c - Pre-adolescent
         d - Adolescent
         e - Adult
         f - Specialized
         g - General
         j - Juvenile
         | - No attempt to code
      23 - Form of item
         # - None of the following
         a - Microfilm
         b - Microfiche
         c - Microopaque
         d - Large print
         f - Braille
         g - Punched paper tape [   ]
         h - Magnetic tape [OBSOLETE]
         i - Multimedia [OBSOLETE]
         o - Online
         q - Direct electronic
         r - Regular print reproduction
         s - Electronic
         x - Other form of reproduction [OBSOLETE]
         z - Other form of reproduction [OBSOLETE]
         | - No attempt to code
      24-29 - Accompanying matter
         # - No accompanying matter
         a - Discography
         b - Bibliography
         c - Thematic index
         d - Libretto or text
         e - Biography of composer or author
         f - Biography of performer or history of ensemble
         g - Technical and/or historical information on instruments
         h - Technical information on music
         i - Historical information
         j - Historical information other than music [OBSOLETE]
         k - Ethnological information
         n - Not applicable [OBSOLETE]
         r - Instructional materials
         s - Music
         z - Other
         | - No attempt to code
      30-31 - Literary text for sound recordings
         # - Item is a musical sound recording
         a - Autobiography
         b - Biography
         c - Conference proceedings
         d - Drama
         e - Essays
         f - Fiction
         g - Reporting
         h - History
         i - Instruction
         j - Language instruction
         k - Comedy
         l - Lectures, speeches
         m - Memoirs
         n - Not applicable
         o - Folktales
         p - Poetry
         r - Rehearsals
         s - Sounds
         t - Interviews
         z - Other
         | - No attempt to code
      32 - Main entry in body of entry [OBSOLETE]
         0 - Main entry not in body of entry
         1 - Main entry in body of entry
         | - No attempt to code
      32 - Undefined
      33 - Transposition and arrangement
         # - Not arrangement or transposition or not specified
         a - Transposition
         b - Arrangement
         c - Both transposed and arranged
         n - Not applicable
         u - Unknown
         | - No attempt to code 
      34 - Undefined
  008--CONTINUING RESOURCES
    Character Positions
      18 - Frequency
         # - No determinable frequency
         a - Annual
         b - Bimonthly
         c - Semiweekly
         d - Daily
         e - Biweekly
         f - Semiannual
         g - Biennial
         h - Triennial
         i - Three times a week
         j - Three times a month
         k - Continuously updated
         m - Monthly
         q - Quarterly
         s - Semimonthly
         t - Three times a year
         u - Unknown
         w - Weekly
         z - Other
         | - No attempt to code
      19 - Regularity
         n - Normalized irregular
         r - Regular
         u - Unknown
         x - Completely irregular
         | - No attempt to code
      20 - ISSN center [OBSOLETE]
         # - No ISSN center code assigned
         0 - International Center
         1 - United States
         2 - United Kingdom
         3 - Australia [OBSOLETE]
         4 - Canada
         5 - Moscow Regional Centre [OBSOLETE]
         6 - Federal Republic of Germany [OBSOLETE]
         7 - France [OBSOLETE]
         8 - Argentina [OBSOLETE]
         9 - Japan [OBSOLETE]
         u - Unknown [OBSOLETE]
         z - Other
         | - No attempt to code
      21 - Type of continuing resource
         # - None of the following
         d - Updating database
         l - Updating loose-leaf
         m - Monographic series
         n - Newspaper
         p - Periodical
         w - Updating Web site
         | - No attempt to code
      22 - Form of original item
         # - None of the following
         a - Microfilm
         b - Microfiche
         c - Microopaque
         d - Large print
         e - Newspaper format
         f - Braille
         g - Punched paper tape [OBSOLETE]
         h - Magnetic tape [OBSOLETE] 
         i - Multimedia [OBSOLETE]
         o - Online
         q - Direct electronic
         s - Electronic
         x - Other physical medium [OBSOLETE]
         z - Other physical medium [OBSOLETE]
         | - No attempt to code
      23 - Form of item
         # - None of the following
         a - Microfilm
         b - Microfiche
         c - Microopaque
         d - Large print
         f - Braille
         g - Punched paper tape [OBSOLETE]
         h - Magnetic tape [OBSOLETE]
         i - Multimedia [OBSOLETE]
         o - Online
         q - Direct electronic
         r - Regular print reproduction
         s - Electronic
         z - Other form of reproduction [OBSOLETE]
         | - No attempt to code
      24 - Nature of entire work
         # - No specified nature of entire work
         a - Abstracts/summaries
         b - Bibliographies
         c - Catalogs
         d - Dictionaries
         e - Encyclopedias
         f - Handbooks
         g - Legal articles
         h - Biography
         i - Indexes
         k - Discographies
         l - Legislation
         m - Theses
         n - Surveys of literature in a subject area
         n - Legal cases and case notes [OBSOLETE]
         o - Reviews
         p - Programmed texts
         q - Filmographies
         r - Directories
         s - Statistics
         t - Technical reports
         u - Standards/specifications
         v - Legal cases and case notes
         w - Law reports and digests
         y - Yearbooks
         z - Treaties
         5 - Calendars
         6 - Comics/graphic novels
         | - No attempt to code
      25-27 - Nature of contents
         # - No specified nature of contents
         a - Abstracts/summaries
         b - Bibliographies
         c - Catalogs
         d - Dictionaries
         e - Encyclopedias
         f - Handbooks
         g - Legal articles
         h - Biography
         i - Indexes
         k - Discographies
         l - Legislation
         m - Theses
         n - Surveys of literature in a subject area
         n - Legal cases and case notes [OBSOLETE]
         o - Reviews
         p - Programmed texts
         q - Filmographies
         r - Directories
         s - Statistics
         t - Technical reports
         u - Standards/specifications
         v - Legal cases and case notes
         w - Law reports and digests
         y - Yearbooks
         z - Treaties
         5 - Calendars
         6 - Comics/graphic novels
         | - No attempt to code
      28 - Government publication
         # - Not a government publication
         a - Autonomous or semi-autonomous component
         c - Multilocal
         f - Federal/national
         i - International intergovernmental
         l - Local
         m - Multistate
         n - Government publication--level undetermined [OBSOLETE]
         o - Government publication--level undetermined
         s - State, provincial, territorial, dependent,etc.
         u - Unknown if item is government publication
         z - Other
         | - No attempt to code
      29 - Conference publication
         0 - Not a conference publication
         1 - Conference publication
         | - No attempt to code
      30-32 - Undefined
      30 - Title page availability [OBSOLETE]
         # - No separate title page issued
         a - In last issue of volume, loose
         b - In last issue of volume, attached
         c - In first issue of next volume, loose
         d - In first issue of next volume, attached
         e - Published separately, free upon request
         f - Published separately, free, automatically sent
         g - Published separately, purchase, request
         u - Unknown
         z - Other title page availability
         | - No attempt to code
      31 - Index availability [OBSOLETE]
         # - No index published
         a - Each issue contains index to its own contents (no volume index), loose
         b - In last issue of volume, loose, separately paged
         c - In last issue of volume, loose, unpaged
         d - In last issue of volume, attached
         e - In first issue of next volume, loose, separately paged
         f - In first issue of next volume, loose, unpaged
         g - In first issue of next volume, attached
         h - Published separately, free, automatically sent
         i - Published separately, free, upon request
         j - Published separately, bound from publisher, free, automatically sent
         k - Published separately, bound from publisher, free, upon request
         l - Received separately, bound from publisher
         m - Supplement or subseries, indexed in parent journal index
         u - Unknown
         z - Other index availability
         | - No attempt to code
      32 - Cumulative index availability [OBSOLETE]
         0 - No cumulative index available
         1 - Cumulative index available
         u - Unknown
         | - No attempt to code
      33 - Original alphabet or script of title
         # - No alphabet or script given/no key title
         a - Basic roman
         b - Extended roman
         c - Cyrillic
         d - Japanese
         e - Chinese
         f - Arabic
         g - Greek
         h - Hebrew
         i - Thai
         j - Devanagari
         k - Korean
         l - Tamil
         u - Unknown
         z - Other
         | - No attempt to code
      34 - Entry convention
         0 - Successive entry
         1 - Latest entry
         2 - Integrated entry
         | - No attempt to code
  008--VISUAL MATERIALS
    Character Positions
      18-20 - Running time for motion pictures and videorecordings
         000 - Running time exceeds three characters
         001-999 - Running time
         --- - Running time unknown
         nnn - Not applicable
         ||| - No attempt to code
      21 - Undefined
      21 - In LC collection [OBSOLETE]
         # - Not in LC
         a - In LC, print note
         b - In LC, do not print note
         u - Unknown
      22 - Target audience
         # - Unknown or not specified
         a - Preschool
         b - Primary
         c - Pre-adolescent
         d - Adolescent
         e - Adult
         f - Specialized
         g - General
         j - Juvenile
         | - No attempt to code
      23-27 - Undefined
      23-27 - Accompanying matter [OBSOLETE]
         # - No accompanying matter
         0 - No [OBSOLETE]
         1 - Yes [OBSOLETE]
         l - Stills
         m - Script material
         o - Posters
         p - Pressbooks
         q - Lobby cards
         r - Instructional materials
         s - Music
         z - Other
         | - No attempt to code
      28 - Government publication
         # - Not a government publication
         a - Autonomous or semi-autonomous component
         c - Multilocal
         f - Federal/national
         i - International intergovernmental
         l - Local
         m - Multistate
         n - Government publication--level undetermined [OBSOLETE]
         o - Government publication--level undetermined
         s - State, provincial, territorial, dependent, etc.
         u - Unknown if item is government publication
         z - Other
         | - No attempt to code
      29 - Form of item
         # - None of the following
         a - Microfilm
         b - Microfiche
         c - Microopaque
         d - Large print
         f - Braille
         o - Online
         q - Direct electronic
         r - Regular print reproduction
         s - Electronic
         | - No attempt to code
      30-32 - Undefined
      32 - Main entry in body of entry [OBSOLETE]
         0 - Main entry not in body of entry
         1 - Main entry in body of entry
         | - No attempt to code
      33 - Type of visual material
         a - Art original
         b - Kit
         c - Art reproduction
         d - Diorama
         e - Electronic videorecording [OBSOLETE]
         f - Filmstrip
         g - Game
         i - Picture
         k - Graphic
         l - Technical drawing
         m - Motion picture
         n - Chart
         o - Flash card
         p - Microscope slide
         q - Model
         r - Realia
         s - Slide
         t - Transparency
         v - Videorecording
         w - Toy
         z - Other
         | - No attempt to code
      34 - Technique
         # - Not applicable [OBSOLETE]
         a - Animation
         c - Animation and live action
         l - Live action
         n - Not applicable
         u - Unknown
         z - Other technique
         | - No attempt to code
  008--MIXED MATERIALS
    Character Positions
      18-22 - Undefined
      23 - Form of item
         # - None of the following
         a - Microfilm
         b - Microfiche
         c - Microopaque
         d - Large print
         f - Braille
         g - Punched paper tape [OBSOLETE]
         h - Magnetic tape [OBSOLETE]
         i - Multimedia [OBSOLETE]
         j - Handwritten transcript [OBSOLETE]
         o - Online
         p - Photocopy [OBSOLETE]
         q - Direct electronic
         r - Regular print reproduction
         s - Electronic
         t - Typewritten transcript [OBSOLETE]
         z - Other form of reproduction [OBSOLETE]
         | - No attempt to code
      24-34 - Undefined
      30 - Case file indicator [OBSOLETE]
         # - No case file exists
         c - Case file exists
      32 - Processing status code [OBSOLETE]
         a - Collection not in library
         b - Completely processed
         c - Processed but with unprocessed additions
         d - Requires processing
         e - Totally unprocessed
         f - Under total cloture
         u - Unknown
      33 - Collection status code [OBSOLETE]
         a - Discrete grouping of material
         b - Accession
         c - Active solicitation
         d - Solicitation unsuccessful
         e - Information file only
         u - Unknown
      34 - Level of collection control code [OBSOLETE]
         a - Control on collection level
         b - Control by series
         c - Control by container
         d - Control by folder
         e - Control by item
         u - Unknown

009 - PHYSICAL DESCRIPTION FIXED-FIELD FOR ARCHIVAL COLLECTION (VM) - [OBSOLETE]
    Character Positions
      00 - Genealogical stage
      01 - Technical stage
      02 - Color stage
      03 - Film emulsion
      04 - Film base
      05 - Negative or positive sound
      06 - Additional types of color
      07 - Longitudinal shrinkage
      08 - Perforation shrinkage
      09 - Film deterioration
      10 - Completeness
      11-14 - Film inspection date


--Number and Code Fields (01X-04X)--
010 - LIBRARY OF CONGRESS CONTROL NUMBER (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - LC control number (NR)
      $b - NUCMC control number (R)
      $z - Canceled/invalid LC control number (R)
      $8 - Field link and sequence number (R)

011 - LINKING LIBRARY OF CONGRESS CONTROL NUMBER (NR) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - LINKING LC control number (R)

013 - PATENT CONTROL INFORMATION (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Number (NR)
      $b - Country (NR)
      $c - Type of number (NR)
      $d - Date (R)
      $e - Status (R)
      $f - Party to document (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

015 - NATIONAL BIBLIOGRAPHY NUMBER (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - National bibliography number (R)
      $q - Qualifying information (R)
      $z - Canceled/Invalid national bibliography number (R)
      $2 - Source (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

016 - NATIONAL BIBLIOGRAPHIC AGENCY CONTROL NUMBER (R)
   Indicators
      First - National bibliographic agency
         # - Library and Archives Canada 
         7 - Agency identified in subfield $2
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Record control number (NR)
      $z - Canceled or invalid record control number (R)
      $2 - Source (NR)
      $8 - Field link and sequence number (R)

017 - COPYRIGHT OR LEGAL DEPOSIT NUMBER (R)
   Indicators
      First - Government jurisdiction (BK MP MU VM)[OBSOLETE]
         0 - United States [OBSOLETE]
         1 - Canada [OBSOLETE] [CAN/MARC only]
         2 - France [OBSOLETE] [CAN/MARC only]
      First - Undefined
         # - Undefined
      Second - Undefined [OBSOLETE]
         # - Undefined [OBSOLETE]
      Second - Display constant controller
         # - Copyright or legal deposit number
         8 - No display constant controller generated
   Subfield Codes
      $a - Copyright or legal deposit number (R)
      $b - Assigning agency (NR)
      $d - Date (NR)
      $i - Display text (NR)
      $z - Canceled/invalid copyright or legal deposit number (R) 
      $2 - Source (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

018 - COPYRIGHT ARTICLE-FEE CODE (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Copyright article-fee code (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

020 - INTERNATIONAL STANDARD BOOK NUMBER (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - International Standard Book Number (NR)
      $c - Terms of availability (NR)
      $q - Qualifying information (R)
      $z - Canceled/invalid ISBN (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

022 - INTERNATIONAL STANDARD SERIAL NUMBER (R)
   Indicators
      First - Level of international interest
         # - No level specified
         0 - Serial of international interest
         1 - Serial not of international interest
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - International Standard Serial Number (NR)
      $l - ISSN-L (NR)
      $m - Canceled ISSN-L (R)
      $y - Incorrect ISSN (R)
      $z - Canceled ISSN (R)
      $2 - Source (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

024 - OTHER STANDARD IDENTIFIER (R)
   Indicators
      First - Type of standard number or code
         0 - International Standard Recording Code (ISRC)
         1 - Universal Product Code (UPC) 
         2 - International Standard Music Number (ISMN) 
         3 - International Article Number (EAN) 
         4 - Serial Item and Contribution Identifier (SICI) 
         7 - Source specified in subfield $2
         8 - Unspecified type of standard number or code
      Second - Difference indicator
         # - No information provided
         0 - No difference
         1 - Difference
   Subfield Codes
      $a - Standard number or code (NR)
      $c - Terms of availability (NR)
      $d - Additional codes following the standard number or code (NR)
      $q - Qualifying information (R)
      $z - Canceled/invalid standard number or code (R)
      $2 - Source of number or code (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

025 - OVERSEAS ACQUISITION NUMBER (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Overseas acquisition number (R)
      $8 - Field link and sequence number (R)

026 - FINGERPRINT IDENTIFIER (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - First and second groups of characters (NR)
      $b - Third and fourth groups of characters (NR)
      $c - Date (NR)
      $d - Number of volume or part (R)
      $e - Unparsed fingerprint (NR)
      $2 - Source (NR)
      $5 - Institution to which field applies (R) 
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

027 - STANDARD TECHNICAL REPORT NUMBER (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Standard technical report number (NR)
      $q - Qualifying information (R)
      $z - Canceled/invalid number (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

028 - PUBLISHER NUMBER OR DISTRIBUTOR NUMBER (R)
   Indicators
      First - Type of number
         0 - Issue number
         1 - Matrix number
         2 - Plate number
         3 - Other music publisher number
         4 - Video recording publisher number
         5 - Other publisher number
         6 - Distributor number
      Second - Note/added entry controller
         0 - No note, no added entry
         1 - Note, added entry
         2 - Note, no added entry
         3 - No note, added entry
   Subfield Codes
      $a - Publisher or distributor number (NR)
      $b - Source (NR)
      $q - Qualifying information (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

030 - CODEN DESIGNATION (R) 
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - CODEN (NR)
      $z - Canceled/invalid CODEN (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

031 - MUSICAL INCIPITS INFORMATION (R) 
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Number of work (NR)
      $b - Number of movement (NR)
      $c - Number of excerpt (NR)
      $d - Caption or heading (R)
      $e - Role  (NR)
      $g - Clef  (NR)
      $m - Voice/instrument (NR)
      $n - Key signature (NR)
      $o - Time signature (NR)
      $p - Musical notation (NR)
      $q - General note (R)
      $r - Key or mode (NR)
      $s - Coded validity note (R)
      $t - Text incipit (R)
      $u - Uniform Resource Identifier (R)
      $y - Link text (R)
      $z - Public note (R)
      $2 - System code (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

032 - POSTAL REGISTRATION NUMBER (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Postal registration number (NR)
      $b - Source (agency assigning number) (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
033 - DATE/TIME AND PLACE OF AN EVENT (R)
   Indicators
      First - Type of date in subfield $a
         # - No date information
         0 - Single date
         1 - Multiple single dates
         2 - Range of dates
      Second - Type of event
         # - No information provided
         0 - Capture
         1 - Broadcast
         2 - Finding
   Subfield Codes
      $a - Formatted date/time (R)
      $b - Geographic classification area code (R)
      $c - Geographic classification subarea code (R)
      $p - Place of event (R)
      $0 - Record control number (R)
      $2 - Source of term (R)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

034 - CODED CARTOGRAPHIC MATHEMATICAL DATA (R)
   Indicators
      First - Type of scale
         0 - Scale indeterminable/No scale recorded
         1 - Single scale
         3 - Range of scales
      Second - Type of ring
         # - Not applicable
         0 - Outer ring
         1 - Exclusion ring
   Subfield Codes
      $a - Category of scale (NR)
         a - Linear scale 
         b - Angular scale
         z - Other type of scale
      $b - Constant ratio linear horizontal scale (R)
      $c - Constant ratio linear vertical scale (R)
      $d - Coordinates--westernmost longitude (NR)
      $e - Coordinates--easternmost longitude (NR)
      $f - Coordinates--northernmost latitude (NR)
      $g - Coordinates--southernmost latitude (NR)
      $h - Angular scale (R)
      $j - Declination--northern limit (NR)
      $k - Declination--southern limit (NR)
      $m - Right ascension--eastern limit (NR)
      $n - Right ascension--western limit (NR)
      $p - Equinox (NR)
      $r - Distance from earth  (NR)
      $s - G-ring latitude (R)
      $t - G-ring longitude (R)
      $x - Beginning date (NR)
      $y - Ending date (NR)
      $z - Name of extraterrestrial body  (NR)
      $0 - Authority record control number or standard number (R)
      $2 - Source  (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

035 - SYSTEM CONTROL NUMBER (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - System control number (NR)
      $z - Canceled/invalid control number (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

036 - ORIGINAL STUDY NUMBER FOR COMPUTER DATA FILES (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Original study number (NR)
      $b - Source (agency assigning number) (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

037 - SOURCE OF ACQUISITION (R)
   Indicators
      First - Source of acquisition sequence
         # - Not applicable/No information provided/Earliest
         2 - Intervening
         3 - Current/Latest
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Stock number (NR)
      $b - Source of stock number/acquisition (NR)
      $c - Terms of availability (R)
      $f - Form of issue (R)
      $g - Additional format characteristics (R)
      $n - Note (R)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

038 - RECORD CONTENT LICENSOR (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Record content licensor (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

040 - CATALOGING SOURCE (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Original cataloging agency (NR)
      $b - Language of cataloging (NR)
      $c - Transcribing agency (NR)
      $d - Modifying agency (R)
      $e - Description conventions (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

041 - LANGUAGE CODE (R)
   Indicators
      First - Translation indication
         # - No information provided
         0 - Item not a translation/does not include a translation
         1 - Item is or includes a translation
      Second - Source of code
         # - MARC language code
         7 - Source specified in subfield $2 
   Subfield Codes
      $a - Language code of text/sound track or separate title (R)
      $b - Language code of summary or abstract (R)
      $c - Languages of separate titles (VM) [OBSOLETE]
      $c - languages of available translation (SE) [OBSOLETE]
      $d - Language code of sung or spoken text (R)
      $e - Language code of librettos (R)
      $f - Language code of table of contents (R)
      $g - Language code of accompanying material other than librettos (R)
      $h - Language code of original and/or intermediate translations of text (R) [REDEFINED]
      $h - Language code of original (R)
      $j - Language code of subtitles or captions (R)
      $k - Language code of intermediate translations (R)
      $m - Language code of original accompanying materials other than librettos (R)
      $n - Language code of original libretto (R)
      $2 - Source of code (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

042 - AUTHENTICATION CODE (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Authentication code (R)
         dc - Dublin Core 
         dhca - Dance Heritage Coalition Access Project
         gamma - Georgia Archives & Manuscripts Automated Access Project
         gils - Government Information Location Service
         isds/c - ISSN Canada
         lc - Library of Congress
         lcac - LC Annotated Children's Cataloging Program
         lccopycat - LC copy cataloging
         lccopycat-nm - LC copy cataloging-Near Match
         lcd - CONSER full authority application
         lcderive - LC derived cataloging
         lchlas - Handbook of Latin American Studies
         lcllh - LC Law Library Hispanic
         lcnccp - LC National Coordinated Cataloging Program
         lcnitrate - LC nitrate film
         lcnuc - National Union Catalog
         lcode - LC overseas data entry
         msc - CONSER minimal authority application
         nlc - National Library of Canada 
         nlmcopyc - National Library of Medicine copy cataloging
         nsdp - National Serial Data Program
         ntccf - LC National Translations Center citation file
         pcc - Program for Cooperative Cataloging
         premarc - LC PreMARC Retrospective Conversion Project
         sanb - South African National Bibliography Project
         xisds/c - ISSN Canada does not consider item a serial
         xlc - LC does not consider item a serial
         xnlc - NLC does not consider item a serial
         xnsdp - NSDP does not consider item a serial

043 - GEOGRAPHIC AREA CODE (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Geographic area code (R)
      $b - Local GAC code (R)
      $c - ISO code (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source of local code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

044 - COUNTRY OF PUBLISHING/PRODUCING ENTITY CODE (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - MARC country code (R)
      $b - Local subentity code (R)
      $c - ISO country code (R)
      $2 - Source of local subentity code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

045 - TIME PERIOD OF CONTENT (NR)
   Indicators 
      First - Type of time period in subfield $b or $c
         # - Subfield $b or $c not present
         0 - Single date/time
         1 - Multiple single dates/times
         2 - Range of dates/times
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Time period code (R)
      $b - Formatted 9999 B.C. through C.E. time period (R)
      $c - Formatted pre-9999 B.C. time period (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

046 - SPECIAL CODED DATES (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Type of date code (NR)
          i - Inclusive dates of collection
          k - Bulk of collection
          m - Multiple dates
          n - Unknown dates
          p - Distribution/release/issue and production/recording session dates
          q - Questionable date
          r - Reissue and originaldates
          s - Single known/probable date
          t - Publication date and copyright dates
          x - Incorrect dates
      $b - Date 1 (B.C.E. date) (NR)
      $c - Date 1 (C.E. date) (NR)
      $d - Date 2 (B.C.E. date) (NR)
      $e - Date 2 (C.E. date) (NR)
      $j - Date resource modified (NR)
      $k - Beginning or single date created (NR)
      $l - Ending date created (NR)
      $m - Beginning of date valid (NR)
      $o - Single or starting date for aggregated content (NR)
      $p - Ending date for aggregated content (NR)
      $n - End of date valid (NR)
      $2 - Source of date (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

047 - FORM OF MUSICAL COMPOSITION CODE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Source of code
         # - MARC musical composition code
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Form of musical composition code (R)
      $2 - Source of code (NR)
      $8 - Field link and sequence number (R)

048 - NUMBER OF MUSICAL INSTRUMENTS OR VOICES CODE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Source of code
         # - MARC code
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Performer or ensemble (R)
      $b - Soloist (R)
      $2 - Source of code (NR)
      $8 - Field link and sequence number (R)
   Instrument or Voices Codes 
      ba - Brass - Horn
      bb - Brass--Trumpet
      bc - Brass--Cornet
      bd - Brass--Trombone
      be - Brass--Tuba
      bf - Brass--Baritone
      bn - Brass--Unspecified
      bu - Brass--Unknown
      by - Brass--Ethnic
      bz - Brass--Other
      ca - Choruses--Mixed
      cb - Choruses--Women's
      cc - Choruses--Men's
      cd - Choruses--Children's
      cn - Choruses--Unspecified
      cu - Choruses--Unknown
      cy - Choruses--Ethnic
      ea - Electronic--Synthesizer
      eb - Electronic--Tape
      ec - Electronic--Computer
      ed - Electronic--Ondes Martinot
      en - Electronic--Unspecified
      eu - Electronic--Unknown
      ez - Electronic--Other
      ka - Keyboard--Piano
      kb - Keyboard--Organ  
      kc - Keyboard--Harpsichord
      kd - Keyboard--Clavichord
      ke - Keyboard--Continuo
      kf - Keyboard--Celeste
      kn - Keyboard--Unspecified
      ku - Keyboard--Unknown
      ky - Keyboard--Ethnic
      kz - Keyboard--Other
      oa - Larger ensemble--Full orchestra
      ob - Larger ensemble--Chamber orch.
      oc - Larger ensemble--String orchestra
      od - Larger ensemble--Band
      oe - Larger ensemble--Dance orchestra
      of - Larger ensemble--Brass band
      on - Larger ensemble--Unspecified
      ou - Larger ensemble--Unknown
      oy - Larger ensemble--Ethnic
      oz - Larger ensemble--Other
      pa - Percussion--Timpani
      pb - Percussion--Xylophone
      pc - Percussion--Marimba
      pd - Percussion--Drum
      pn - Percussion--Unspecified
      pu - Percussion--Unknown
      py - Percussion--Ethnic
      pz - Percussion--Other
      sa - Strings, bowed--Violin
      sb - Strings, bowed--Viola
      sc - Strings, bowed--Violoncello
      sd - Strings, bowed--Double bass
      se - Strings, bowed--Viol
      sf - Strings, bowed--Viola d'amore
      sg - Strings, bowed--Viola da gamba
      sn - Strings, bowed--Unspecified
      su - Strings, bowed--Unknown
      sy - Strings, bowed--Ethnic
      sz - Strings, bowed--Other
      ta - Strings, plucked--Harp
      tb - Strings, plucked--Guitar
      tc - Strings, plucked--Lute
      td - Strings, plucked--Mandolin
      tn - Strings, plucked--Unspecified
      tu - Strings, plucked--Unknown
      ty - Strings, plucked--Ethnic
      tz - Strings, plucked--Other
      va - Voices--Soprano
      vb - Voices--Mezzo Soprano
      vc - Voices--Alto
      vd - Voices--Tenor
      ve - Voices--Baritone
      vf - Voices--Bass
      vg - Voices--Counter tenor
      vh - Voices--High voice
      vi - Voices--Medium voice
      vj - Voices--Low voice
      vn - Voices--Unspecified
      vu - Voices--Unknown
      vy - Voices--Ethnic
      wa - Woodwinds--Flute
      wb - Woodwinds--Oboe
      wc - Woodwinds--Clarinet
      wd - Woodwinds--Bassoon
      we - Woodwinds--Piccolo
      wf - Woodwinds--English horn
      wg - Woodwinds--Bass clarinet
      wh - Woodwinds--Recorder
      wi - Woodwinds--Saxophone
      wn - Woodwinds--Unspecified
      wu - Woodwinds--Unknown
      wy - Woodwinds--Ethnic
      wz - Woodwinds--Other
      zn - Unspecified instruments
      zu - Unknown


--Classification and Call Number Fields (05X-08X)--
050 - LIBRARY OF CONGRESS CALL NUMBER (R)
   Indicators
      First - Existence in LC collection
         # - No information provided
         0 - Item is in LC
         1 - Item is not in LC
      Second - Source of call number
         # - No information provided [OBSOLETE]
         0 - Assigned by LC
         4 - Assigned by agency other than LC
      Second - Series call number (SE) [OBSOLETE]
         0 - No series involved
         1 - Main series
         2 - Subseries
         3 - Sub-subseries
   Subfield Codes
      $a - Classification number (R)
      $b - Item number (NR)
      $d - Supplementary class number (MU) [OBSOLETE]
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)


051 - LIBRARY OF CONGRESS COPY, ISSUE, OFFPRINT STATEMENT (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
      Second - Series call number (SE) [OBSOLETE]
         0 - No series involved
         1 - Main series
         2 - Subseries
         3 - Sub-subseries
   Subfield Codes
      $a - Classification number (NR)
      $b - Item number (NR)
      $c - Copy information (NR)
      $8 - Field link and sequence number (R)

052 - GEOGRAPHIC CLASSIFICATION (R)
   Indicators
      First - Code source
         # - Library of Congress Classification
         0 - U.S. Dept. of Defense Classification [OBSOLETE]
         1 - U.S. Dept. of Defense Classification
         7 - Source specified in subfield $2
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Geographic classification area code (NR)
      $b - Geographic classification subarea code (R)
      $c - Subject (MP) [OBSOLETE]
      $d - Populated place name (R)
      $2 - Code source (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

055 - CLASSIFICATION NUMBERS ASSIGNED IN CANADA (R)
   Indicators
      First - Existence in LAC collection
         # - Information not provided
         0 - Work held by LAC
         1 - Work not held by LAC
      Second - Type, completeness, source of class/call number
         0 - LC-based call number assigned by LAC
         1 - Complete LC class number assigned by LAC
         2 - Incomplete LC class number assigned by LAC
         3 - LC-based call number assigned by the contributing library
         4 - Complete LC class number assigned by the contributing library
         5 - Incomplete LC class number assigned by the contributing library
         6 - Other call number assigned by LAC
         7 - Other class number assigned by LAC
         8 - Other call number assigned by the contributing library
         9 - Other class number assigned by the contributing library
   Subfield Codes
      $a - Classification number (NR)
      $b - Item number (NR)
      $2 - Source of call/class number (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

060 - NATIONAL LIBRARY OF MEDICINE CALL NUMBER (R)
   Indicators
      First - Existence in NLM collection
         # - No information provided
         0 - Item is in NLM
         1 - Item is not in NLM
      Second - Source of call number
         # - No information provided [OBSOLETE]
         0 - Assigned by NLM
         4 - Assigned by agency other than NLM
      Second - Series call number (SE) [OBSOLETE]
         0 - No series involved
         1 - Main series
         2 - Subseries
         3 - Sub-subseries
   Subfield Codes
      $a - Classification number (R)
      $b - Item number (NR)
      $8 - Field link and sequence number (R)

061 - NATIONAL LIBRARY OF MEDICINE COPY STATEMENT (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
      Second - Series call number (SE) [OBSOLETE]
         0 - No series involved
         1 - Main series
         2 - Subseries
         3 - Sub-subseries
   Subfield Codes
      $a - Classification number (R)
      $b - Item number (NR)
      $c - Copy information (NR)
      $8 - Field link and sequence number (R)

066 - CHARACTER SETS PRESENT (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Primary G0 character set (NR)
      $b - Primary G1 character set (NR)
      $c - Alternate G0 or G1 character set (R)

070 - NATIONAL AGRICULTURAL LIBRARY CALL NUMBER (R)
   Indicators
      First - Existence in NAL collection
         0 - Item is in NAL
         1 - Item is not in NAL
      Second - Undefined
         # - Undefined
      Second - Series call number (SE) [OBSOLETE]
         0 - No series involved
         1 - Main series
         2 - Subseries
         3 - Sub-subseries
   Subfield Codes
      $a - Classification number (R)
      $b - Item number (NR)
      $8 - Field link and sequence number (R)

071 - NATIONAL AGRICULTURAL LIBRARY COPY STATEMENT (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
      Second - Series call number (SE) [OBSOLETE]
         0 - No series involved
         1 - Main series
         2 - Subseries
         3 - Sub-subseries
   Subfield Codes
      $a - Classification number (R)
      $b - Item number (NR)
      $c - Copy information (NR)
      $8 - Field link and sequence number (R)

072 - SUBJECT CATEGORY CODE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Code source
         0 - NAL subject category code list
         7 - Code source specified in subfield $2
   Subfield Codes
      $a - Subject category code (NR)
      $x - Subject category code subdivision (R)
      $2 - Source (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

074 - GPO ITEM NUMBER (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - GPO item number (NR)
      $z - Canceled/invalid GPO item number (R)
      $8 - Field link and sequence number (R)

080 - UNIVERSAL DECIMAL CLASSIFICATION NUMBER (R)
   Indicators
      First - Type of edition
         # - No information provided
         0 - Full
         1 - Abridged
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Universal Decimal Classification number (NR)
      $b - Item number (NR)
      $x - Common auxiliary subdivision (R)
      $2 - Edition identifier (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

082 - DEWEY DECIMAL CLASSIFICATION NUMBER (R)
   Indicators
      First - Type of edition
         # - No edition information recorded (BK CF MU VM SE) [OBSOLETE]
         0 - Full edition
         1 - Abridged edition
         2 - Abridged NST version (BK MU VM SE) [OBSOLETE]
         7 - Other edition specified in subfield $2
      Second - Source of classification number
         # - No information provided
         0 - Assigned by LC
         4 - Assigned by agency other than LC
   Subfield Codes
      $a - Classification number (R)
      $b - Item number (NR)
      $b - DDC number--abridged NST version (SE) [OBSOLETE]
      $m - Standard or optional designation (NR)
      $q - Assigning agency (NR)
      $2 - Edition number (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

083 - ADDITIONAL DEWEY DECIMAL CLASSIFICATION NUMBER (R)
   Indicators
      First - Type of edition
         0 - Full edition
         1 - Abridged edition
         7 - Other edition specified in subfield $2
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Classification number (R)
      $c - Classification number--Ending number of span (R)
      $m - Standard or optional designation (NR)
      $q - Assigning agency (NR)
      $y - Table sequence number for internal subarrangement or add table (R)
      $z - Table identification (R)
      $2 - Edition number (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

084 - OTHER CLASSIFICATION NUMBER (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Classification number (R)
      $b - Item number (NR)
      $q - Assigning agency (NR)
      $2 - Source of number (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
085 - SYNTHESIZED CLASSIFICATION NUMBER COMPONENTS (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Number where instructions are found-single number or beginning number of span (R)
      $b - Base number (R)
      $c - Classification number-ending number of span (R)
      $f - Facet designator (R)
      $r - Root number (R)
      $s - Digits added from classification number in schedule or external table (R)
      $t - Digits added from internal subarrangement or add table (R)
      $u - Number being analyzed (R)
      $v - Number in internal subarrangement or add table where instructions are found (R)
      $w - Table identification-Internal subarrangement or add table (R)
      $y - Table sequence number for internal subarrangement or add table (R)
      $z - Table identification (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

086 - GOVERNMENT DOCUMENT CLASSIFICATION NUMBER (R)
   Indicators
      First - Number source
         # - Source specified in subfield $2
         # - Undefined (BK MP MU VM SE) [OBSOLETE]
         0 - Superintendent of Documents Classification System
         1 - Government of Canada Publications: Outline of Classification
      First - Government jurisdiction (BK MP MU VM SE) [OBSOLETE]
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Classification number (NR)
      $z - Canceled/invalid classification number (R)
      $2 - Number source (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

088 - REPORT NUMBER (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Report number (NR)
      $z - Canceled/invalid report number (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

090 - LOCAL CALL NUMBER (BK AM CF MP MU VM SE) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Local class number (NR)
      $b - Local Cutter number (NR)

090 - SHELF LOCATION (AM)[OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Shelf location (NR)

091 - MICROFILM SHELF LOCATION (AM) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Microfilm shelf location (NR)


--Main Entry Fields (1XX)--
100 - MAIN ENTRY--PERSONAL NAME (NR)
   Indicators
      First - Type of personal name entry element
         0 - Forename
         1 - Surname
         2 - Multiple surname [OBSOLETE]
         3 - Family name
      Second - Undefined
         # - Undefined
      Second - Main entry/subject relationship (BK MU SE) [OBSOLETE]
   Subfield Codes
      $a - Personal name (NR)
      $b - Numeration (NR)
      $c - Titles and other words associated with a name (R)
      $d - Dates associated with a name (NR)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $j - Attribution qualifier (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $n - Number of part/section of a work (R)
      $p - Name of part/section of a work (R)
      $q - Fuller form of name (NR)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $0 - Authority record control number or standard number (R)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

110 - MAIN ENTRY--CORPORATE NAME (NR)
   Indicators
      First - Type of corporate name entry element
         0 - Inverted name
         1 - Jurisdiction name
         2 - Name in direct order
      Second - Undefined
         # - Undefined
      Second - Main entry/subject relationship (BK MU SE) [OBSOLETE]
   Subfield Codes
      $a - Corporate name or jurisdiction name as entry element (NR)
      $b - Subordinate unit (R)
      $c - Location of meeting (R)
      $d - Date of meeting or treaty signing (R)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $n - Number of part/section/meeting (R)
      $p - Name of part/section of a work (R)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $0 - Authority record control number or standard number (R)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

111 - MAIN ENTRY--MEETING NAME (NR)
   Indicators
      First - Type of meeting name entry element
         0 - Inverted name 
         1 - Jurisdiction name
         2 - Name in direct order
      Second - Undefined
         # - Undefined
      Second - Main entry/subject relationship (BK MU SE) [OBSOLETE]
   Subfield Codes
      $a - Meeting name or jurisdiction name as entry element (NR)
      $b - Number (BK CF MP MU SE VM MX) [OBSOLETE]
      $c - Location of meeting (R)
      $d - Date of meeting (NR)
      $e - Subordinate unit (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $j - Relator term (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $n - Number of part/section/meeting (R)
      $p - Name of part/section of a work (R)
      $q - Name of meeting following jurisdiction name entry element (NR)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $0 - Authority record control number or standard number (R)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

130 - MAIN ENTRY--UNIFORM TITLE (NR)
   Indicators 
      First - Nonfiling characters
         0-9 - Number of nonfiling characters present
         # - Nonfiling characters not specified [OBSOLETE]
      Second - Undefined
         # - Undefined
      Second - Main entry/subject relationship (BK MU SE) [OBSOLETE]
   Subfield Codes
      $a - Uniform title (NR)
      $d - Date of treaty signing (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section of a work (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $r - Key for music (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $0 - Authority record control number or standard number (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)


--Title and Title-Related Fields (20X-24X)--
210 - ABBREVIATED TITLE (R)
   Indicators
      First - Title added entry
         0 - No added entry
         1 - Added entry
      Second - Type
         # - Abbreviated key title
         0 - Other abbreviated title
   Subfield Codes
      $a - Abbreviated title (NR)
      $b - Qualifying information (NR)
      $2 - Source (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

211 - ACRONYM OR SHORTENED TITLE (R) [OBSOLETE]
   Indicators
      First - Title added entry
         0 - No title added entry
         1 - Title added entry
      Second - Nonfiling characters
         0-9 - Number of nonfiling characters present
   Subfield Codes
      $a - Acronym or shortened title (NR)
      $6 - Linkage (NR)

212 - VARIANT ACCESS TITLE (R) [OBSOLETE]
   Indicators
      First - Title added entry
         0 - No title added entry
         1 - Title added entry
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Variant access title (NR)
      $6 - Linkage (NR)

214 - AUGMENTED TITLE (R) [OBSOLETE]
   Indicators
      First - Title added entry
         0 - No title added entry
         1 - Title added entry
      Second - Nonfiling characters
         0-9 - Number of nonfiling characters present
   Subfield Codes
      $a - Augmented title (NR)
      $6 - Linkage (NR)

222 - KEY TITLE (R)
   Indicators
      First - Undefined
         # - Undefined
      First - Specifies whether variant title and/or added entry is required (CF SE) [OBSOLETE]
         0 - No key title added entry; title proper same
         1 - Key title added entry; title proper different
         2 - Key title added entry; title proper same
         3 - No key title added entry; title proper different
      Second - Nonfiling characters
         0-9 - Number of nonfiling characters
   Subfield Codes
      $a - Key title (NR)
      $b - Qualifying information (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

240 - UNIFORM TITLE (NR)
   Indicators
      First - Uniform title printed or displayed
         0 - Not printed or displayed
         1 - Printed or displayed
         2 - Not printed on card, title added entry (MU) [OBSOLETE]
         3 - Printed on card, title added entry (MU) [OBSOLETE]
      Second - Nonfiling characters
         0-9 - Number of nonfiling characters
   Subfield Codes
      $a - Uniform title (NR)
      $d - Date of treaty signing (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section of a work (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $r - Key for music (NR)
      $s - Version (NR)
      $0 - Authority record control number or standard number (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

241 - ROMANIZED TITLE (BK AM CF MP MU VM) (NR) [OBSOLETE]
   Indicators
      First - Title added entry
         0 - No title added entry
         1 - Title added entry
      Second - Nonfiling characters
         0-9 - Number of nonfiling characters
   Subfield Codes
      $a - Romanized title (NR)
      $h - Medium (NR)

242 - TRANSLATION OF TITLE BY CATALOGING AGENCY (R)
   Indicators
      First - Title added entry
         0 - No added entry
         1 - Added entry
      Second - Nonfiling characters
         0-9 - Number of nonfiling characters
   Subfield Codes
      $a - Title (NR)
      $b - Remainder of title (NR)
      $c - Statement of responsibility, etc. (NR)
      $d - Designation of section (BK AM MP MU VM SE) [OBSOLETE]
      $e - Name of part/section (BK AM MP MU VM SE) [OBSOLETE]
      $h - Medium (NR)
      $n - Number of part/section of a work (R)
      $p - Name of part/section of a work (R)
      $y - Language code of translated title (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

243 - COLLECTIVE UNIFORM TITLE (NR)
   Indicators 
      First - Uniform title printed or displayed
         0 - Not printed or displayed
         1 - Printed or displayed
         2 - Not printed on card, title added entry (MU) [OBSOLETE]
         3 - Printed on card, title added entry (MU) [OBSOLETE]
      Second - Nonfiling characters
         0-9 - Number of nonfiling characters
   Subfield Codes
      $a - Uniform title (NR)
      $d - Date of treaty signing (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section of a work (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $r - Key for music (NR)
      $s - Version (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

245 - TITLE STATEMENT (NR)
   Indicators
      First - Title added entry
         0 - No added entry
         1 - Added entry
      Second - Nonfiling characters
         0-9 - Number of nonfiling characters
   Subfield Codes
      $a - Title (NR)
      $b - Remainder of title (NR)
      $c - Statement of responsibility, etc. (NR)
      $d - Designation of section (SE) [OBSOLETE]
      $e - Name of part/section (SE) [OBSOLETE]
      $f - Inclusive dates (NR)
      $g - Bulk dates (NR)
      $h - Medium (NR)
      $k - Form (R)
      $n - Number of part/section of a work (R)
      $p - Name of part/section of a work (R)
      $s - Version (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

246 - VARYING FORM OF TITLE (R)
   Indicators
      First - Note/added entry controller
         0 - Note, no added entry
         1 - Note, added entry
         2 - No note, no title added entry
         3 - No note, added entry 
      Second - Type of title
         # - No type specified
         0 - Portion of title
         1 - Parallel title
         2 - Distinctive title
         3 - Other title
         4 - Cover title
         5 - Added title page title
         6 - Caption title
         7 - Running title
         8 - Spine title
   Subfield Codes
      $a - Title proper/short title (NR)
      $b - Remainder of title (NR)
      $d - Designation of section (SE) [OBSOLETE]
      $e - Name of part/section (SE) [OBSOLETE]
      $f - Date or sequential designation (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $i - Display text (NR)
      $n - Number of part/section of a work (R)
      $p - Name of part/section of a work (R)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

247 - FORMER TITLE (R)
   Indicators
      First - Title added entry
         0 - No added entry
         1 - Added entry
      Second - Note controller
         0 - Display note
         1 - Do not display note
   Subfield Codes
      $a - Title (NR)
      $b - Remainder of title (NR)
      $d - Designation of section (SE) [OBSOLETE]
      $e - Name of part/section (SE) [OBSOLETE]
      $f - Date or sequential designation (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $n - Number of part/section of a work (R)
      $p - Name of part/section of a work (R)
      $x - International Standard Serial Number (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)


--Edition, Imprint, etc. Fields 250-270--
250 - EDITION STATEMENT (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Edition statement (NR)
      $b - Remainder of edition statement (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

254 - MUSICAL PRESENTATION STATEMENT (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Musical presentation statement (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

255 - CARTOGRAPHIC MATHEMATICAL DATA (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Statement of scale (NR)
      $b - Statement of projection (NR)
      $c - Statement of coordinates (NR)
      $d - Statement of zone (NR)
      $e - Statement of equinox (NR)
      $f - Outer G-ring coordinate pairs (NR)
      $g - Exclusion G-ring coordinate pairs (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

256 - COMPUTER FILE CHARACTERISTICS (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Computer file characteristics (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

257 - COUNTRY OF PRODUCING ENTITY (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Country of producing entity (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

258 - PHILATELIC ISSUE DATE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Issuing jurisdiction (NR)
      $b - Denomination (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

260 - PUBLICATION, DISTRIBUTION, ETC. (IMPRINT) (R)
   Indicators
      First - Sequence of publishing statements
         # - Not applicable/No information provided/Earliest available publisher
         2 - Intervening publisher
         3 - Current/latest publisher
      Second - Undefined
         # - Undefined
      First - Presence of publisher in imprint (BK MP MU SE) [OBSOLETE]
         0 - Publisher, distributor, etc. is present
         1 - Publisher, distributor, etc. is not present
      Second - Added entry/publisher relationship (SE) [OBSOLETE]
         0 - Publisher, distributor, etc. not same as issuing body in added entry
         1 - Publisher, distributor, etc. same as issuing body in added entry
   Subfield Codes
      $a - Place of publication, distribution, etc. (R)
      $b - Name of publisher, distributor, etc. (R)
      $c - Date of publication, distribution, etc. (R)
      $d - Plate or publisher's number for music (Pre-AACR 2) (NR) [LOCAL]
      $e - Place of manufacture (R)
      $f - Manufacturer (R)
      $g - Date of manufacture (R)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
261 - IMPRINT STATEMENT FOR FILMS (Pre-AACR 1 Revised) (NR) [LOCAL]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Producing company (R)
      $b - Releasing company (primary distributor) (R)
      $d - Date of production, release, etc. (R)
      $e - Contractual producer (R)
      $f - Place of production, release, etc. (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

262 - IMPRINT STATEMENT FOR SOUND RECORDINGS (Pre-AACR 2) (NR) [LOCAL]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Place of production, release, etc. (NR)
      $b - Publisher or trade name (NR)
      $c - Date of production, release, etc. (NR)
      $k - Serial identification (NR)
      $l - Matrix and/or take number (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

263 - PROJECTED PUBLICATION DATE (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Projected publication date (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
264 - PRODUCTION, PUBLICATION, DISTRIBUTION, MANUFACTURE, AND COPYRIGHT NOTICE (R)
   Indicators
      First - Sequence of statements
         # - Not applicable/No information provided/Earliest
         2 - Intervening
         3 - Current/latest
      Second - Function of entity
         0 - Production
         1 - Publication
         2 - Distribution
         3 - Manufacture
         4 - Copyright notice date
   Subfield Codes
      $a - Place of production, publication, distribution, manufacture (R)
      $b - Name of producer, publisher, distributor, manufacturer (R)
      $c - Date of production, publication, distribution, manufacture, or copyright notice (R)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

265 - SOURCE FOR ACQUISITION/SUBSCRIPTION ADDRESS (NR) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Source for acquisition/subscription address (R)
      $6 - Linkage (NR)

270 - ADDRESS (R)
   Indicators
      First - Level
         # - No level specified
         1 - Primary
         2 - Secondary
      Second - Type of address
         # - No type specified
         0 - Mailing
         7 - Type specified in subfield $i
   Subfield Codes
      $a - Address (R)
      $b - City (NR)
      $c - State or province (NR)
      $d - Country (NR)
      $e - Postal code (NR)
      $f - Terms preceding attention name (NR)
      $g - Attention name (NR)
      $h - Attention position (NR)
      $i - Type of address (NR)
      $j - Specialized telephone number (R)
      $k - Telephone number (R)
      $l - Fax number (R)
      $m - Electronic mail address (R)
      $n - TDD or TTY number (R)
      $p - Contact person (R)
      $q - Title of contact person (R)
      $r - Hours (R)
      $z - Public note (R)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)


--Physical Description, etc. Fields (3XX)--
300 - PHYSICAL DESCRIPTION (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Extent (R)
      $b - Other physical details (NR)
      $c - Dimensions (R)
      $e - Accompanying material (NR)
      $f - Type of unit (R)
      $g - Size of unit (R)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

301 - PHYSICAL DESCRIPTION FOR FILMS (PRE-AACR 2) (VM) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Extent of item (NR)
      $b - Sound characteristics (NR)
      $c - Color characteristics (NR)
      $d - Dimensions (NR)
      $e - Accompanying material (NR)
      $f - Speed (NR)

302 - PAGE OR ITEM COUNT (BK AM) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Page count (NR)

303 - UNIT COUNT (AM) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Unit count (NR)

304 - LINEAR FOOTAGE (AM) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Linear footage (NR)

305 - PHYSICAL DESCRIPTION FOR SOUND RECORDINGS (Pre-AACR 2) (MU) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Extent (NR)
      $b - Other physical details (NR)
      $c - Dimensions (NR)
      $d - Microgroove or standard (NR)
      $e - Stereophonic, monaural (NR)
      $f - Number of tracks (NR)
      $m - Serial identification (NR)
      $n - Matrix and/or take number (NR)
      $6 - Linkage (NR)

306 - PLAYING TIME (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Playing time (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

307 - HOURS, ETC. (R)
   Indicators
      First - Display constant controller
         # - Hours
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Hours (NR)
      $b - Additional information (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

308 - PHYSICAL DESCRIPTION FOR FILMS (ARCHIVAL) (VM) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Number of reels (NR)
      $b - Footage (NR)
      $c - Sound characteristics (NR)
      $d - Color characteristics (NR)
      $e - Width (NR)
      $f - Presentation format (NR)
      $6 - Linkage (NR)

310 - CURRENT PUBLICATION FREQUENCY (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Current publication frequency (NR)
      $b - Date of current publication frequency (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

315 - FREQUENCY (NR) (CF MP) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Frequency (R)
      $b - Dates of frequency (R)
      $6 - Linkage (NR)

321 - FORMER PUBLICATION FREQUENCY (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Former publication frequency (NR)
      $b - Dates of former publication frequency (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
336 - CONTENT TYPE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Content type term (R)
      $b - Content type code (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
337 - MEDIA TYPE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Media type term (R)
      $b - Media type code (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
338 - CARRIER TYPE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Carrier type term (R)
      $b - Carrier type code (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)	
	          	  
340 - PHYSICAL MEDIUM (R)
   Indicators 
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Material base and configuration (R)
      $b - Dimensions (R)
      $c - Materials applied to surface (R)
      $d - Information recording technique (R)
      $e - Support (R)
      $f - Production rate/ratio (R)
      $h - Location within medium (R)
      $i - Technical specifications of medium (R)
      $j - Generation (R)
      $k - Layout (R)
      $m - Book format (R)
      $n - Font size (R)
      $o - Polarity (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

342 - GEOSPATIAL REFERENCE DATA (R)
   Indicators
      First - Geospatial reference dimension
         0 - Horizontal coordinate system
         1 - Vertical coordinate system
      Second - Geospatial reference method
         0 - Geographic
         1 - Map projection
         2 - Grid coordinate system
         3 - Local planar
         4 - Local
         5 - Geodetic model
         6 - Altitude
         7 - Method specified in $2
         8 - Depth
   Subfield Codes
      $a - Name (NR)
      $b - Coordinate or distance units (NR)
      $c - Latitude resolution (NR)
      $d - Longitude resolution (NR)
      $e - Standard parallel or oblique line latitude (R)
      $f - Oblique line longitude (R)
      $g - Longitude of central meridian or projection center (NR)
      $h - Latitude of projection origin or projection center (NR)
      $i - False easting (NR)
      $j - False northing (NR)
      $k - Scale factor (NR)
      $l - Height of perspective point above surface (NR)
      $m - Azimuthal angle (NR)
      $n - Azimuth measure point longitude or straight vertical longitude from pole (NR)
      $o - Landsat number and path number (NR)
      $p - Zone identifier (NR)
      $q - Ellipsoid name (NR)
      $r - Semi-major axis (NR)
      $s - Denominator of flattening ratio (NR)
      $t - Vertical resolution (NR)
      $u - Vertical encoding method (NR)
      $v - Local planar, local, or other projection or grid description (NR)
      $w - Local planar or local georeference information (NR)
      $2 - Reference method used (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

343 - PLANAR COORDINATE DATA (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Planar coordinate encoding method (NR)
      $b - Planar distance units (NR)
      $c - Abscissa resolution (NR)
      $d - Ordinate resolution (NR)
      $e - Distance resolution (NR)
      $f - Bearing resolution (NR)
      $g - Bearing units (NR)
      $h - Bearing reference direction (NR)
      $i - Bearing reference meridian (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
344 - SOUND CHARACTERISTICS (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Type of recording (R)
      $b - Recording medium (R)
      $c - Playing speed (R)
      $d - Groove characteristic (R)
      $e - Track configuration (R)
      $f - Tape configuration (R)
      $g - Configuration of playback channels (R)
      $h - Special playback characteristics (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

345 - PROJECTION CHARACTERISTICS OF MOVING IMAGE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Presentation format (R)
      $b - Projection speed (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
346 - VIDEO CHARACTERISTICS (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Video format (R)
      $b - Broadcast standard (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

347 - DIGITAL FILE CHARACTERISTICS (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - File type (R)
      $b - Encoding format (R)
      $c - File size (R)
      $d - Resolution (R)
      $e - Regional encoding (R)
      $f - Encoded bitrate (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
      
348 - FORMAT OF NOTATED MUSIC (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Format of notated music term (R)
      $b - Format of notated music code (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source of term (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)      

350 - PRICE (NR) (BK AM CF MU VM SE) [OBSOLETE] 
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Price (R)
      $b - Form of issue (R)
      $6 - Linkage (NR)

351 - ORGANIZATION AND ARRANGEMENT OF MATERIALS (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Organization (R)
      $b - Arrangement (R)
      $c - Hierarchical level (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

352 - DIGITAL GRAPHIC REPRESENTATION (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Direct reference method (NR)
      $b - Object type (R)
      $c - Object count (R)
      $d - Row count (NR)
      $e - Column count (NR)
      $f - Vertical count (NR)
      $g - VPF topology level (NR)
      $i - Indirect reference description (NR)
      $q - Format of the digital image (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

355 - SECURITY CLASSIFICATION CONTROL (R)
   Indicators
      First - Controlled element
         0 - Document
         1 - Title
         2 - Abstract
         3 - Contents note
         4 - Author
         5 - Record
         8 - Other element
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Security classification (NR)
      $b - Handling instructions (R)
      $c - External dissemination information (R)
      $d - Downgrading or declassification event (NR)
      $e - Classification system (NR)
      $f - Country of origin code (NR)
      $g - Downgrading date (NR)
      $h - Declassification date (NR)
      $j - Authorization (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

357 - ORIGINATOR DISSEMINATION CONTROL (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfields
      $a - Originator control term (NR)
      $b - Originating agency (R)
      $c - Authorized recipients of material (R)
      $g - Other restrictions (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

359 - RENTAL PRICE (VM) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Rental price (NR)

362 - DATES OF PUBLICATION AND/OR SEQUENTIAL DESIGNATION (R)
   Indicators
      First - Format of date
         0 - Formatted style
         1 - Unformatted note
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Dates of publication and/or sequential designation (NR)
      $z - Source of information (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

363 - NORMALIZED DATE AND SEQUENTIAL DESIGNATION (R)
   Indicators
      First - Start/End designator
         # - No information provided          
         0 - Starting information          
         1 - Ending information 
      Second - State of issuance
         # - Not specified
         0 - Closed
         1 - Open 
   Subfield Codes
      $a - First level of enumeration (NR)       
      $b - Second level of enumeration (NR)       
      $c - Third level of enumeration (NR)       
      $d - Fourth level of enumeration (NR)       
      $e - Fifth level of enumeration (NR)       
      $f - Sixth level of enumeration (NR)       
      $g - Alternative numbering scheme, first level of enumeration (NR)       
      $h - Alternative numbering scheme, second level of enumeration (NR)       
      $i - First level of chronology (NR)
      $j - Second level of chronology (NR) 
      $k - Third level of chronology (NR) 
      $l - Fourth level of chronology (NR) 
      $m - Alternative numbering scheme, chronology (NR) 
      $u - First level textual designation (NR) 
      $v - First level of chronology, issuance (NR) 
      $x - Nonpublic note (R)
      $z - Public note (R) 
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (NR)

365 - TRADE PRICE (R)
   Indicators
      First - Undefined
         # - Undefined 
      Second - Undefined
         # - Undefined 
   Subfield Codes
      $a - Price type code (NR)
      $b - Price amount (NR)
      $c - Currency code (NR)
      $d - Unit of pricing (NR)
      $e - Price note (NR)
      $f - Price effective from (NR)
      $g - Price effective until (NR)
      $h - Tax rate 1 (NR)
      $i - Tax rate 2 (NR)
      $j - ISO country code (NR)
      $k - MARC country code (NR)
      $m - Identification of pricing entity (NR)
      $2 - Source of price type code (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

366 - TRADE AVAILABILITY INFORMATION (R)
   Indicators
      First - Undefined
         # - Undefined 
      Second - Undefined
         # - Undefined 
   Subfield Codes
      $a - Publishers' compressed title identification (NR)
      $b - Detailed date of publication (NR)
      $c - Availability status code (NR)
      $d - Expected next availability date (NR)
      $e - Note (NR)
      $f - Publishers' discount category (NR)
      $g - Date made out of print (NR)
      $j - ISO country code (NR)
      $k - MARC country code (NR)
      $m - Identification of agency (NR)
      $2 - Source of availability status code (NR)
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (R)

370 - ASSOCIATED PLACE (R)
   Indicators
      First - Undefined
         # - Undefined 
      Second - Undefined
         # - Undefined 
   Subfield Codes
      $c - Associated country (R)
      $f - Other associated place (R)
      $g - Place of origin of work (R)
      $s - Start period (NR)
      $t - End period (NR)
      $u - Uniform Resource Identifier (R)
      $v - Source of information (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source of term (NR)
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (R)
	  
377 - ASSOCIATED LANGUAGE (R)
   Indicators
      First - Undefined
         # - Undefined 
      Second - Source of code
         # - MARC language code
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Language code (R)
      $l - Language term (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (R)
	  
380 - FORM OF WORK (R)
   Indicators
      First - Undefined
         # - Undefined 
      Second - Undefined
         # - Undefined 
   Subfield Codes
      $a - Form of work (R)
      $0 - Record control number (R)
      $2 - Source of term (NR)
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (R)
	  
381 - OTHER DISTINGUISHING CHARACTERISTICS OF WORK OR EXPRESSION (R)
   Indicators
      First - Undefined
         # - Undefined 
      Second - Undefined
         # - Undefined 
   Subfield Codes
      $a - Other distinguishing characteristic (R)
      $u - Uniform Resource Identifier (R)
      $v - Source of information (R)
      $0 - Record control number (R)
      $2 - Source of term (NR)
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (R)
	  
382 - MEDIUM OF PERFORMANCE (R)
   Indicators
      First - Display constant controller
         # - No information provided
         0 - Medium of performance
         1 - Partial medium of performance 
      Second - Access control
         # - No information provided
         0 - Not intended for access
         1 - Intended for access
   Subfield Codes
      $a - Medium of performance (R)
      $b - Soloist (R)
      $d - Doubling instrument (R)
      $e - Number of ensembles of the same type (R)
      $n - Number of performers of the same medium (R)
      $p - Alternative medium of performance (R)
      $r - Total number of individuals performing alongside ensembles (NR)
      $s - Total number of performers (NR)
      $t - Total number of ensembles (NR)
      $v - Note (R)
      $0 - Record control number (R)
      $2 - Source of term (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (R)
	  
383 - NUMERIC DESIGNATION OF MUSICAL WORK (R)
   Indicators
      First - Undefined
         # - Undefined 
      Second - Undefined
         # - Undefined 
   Subfield Codes
      $a - Serial number (R)
      $b - Opus number (R)
      $c - Thematic index number (R)
      $d - Thematic index code (NR)
      $e - Publisher associated with opus number (NR)
      $2 - Source (NR)
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (R)
	  
384 - KEY (NR)
   Indicators
      First - Key type
         # - Relationship to original unknown
         0 - Original key
         1 - Transposed key 
      Second - Undefined
         # - Undefined 
   Subfield Codes
      $a - Key (NR)
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (R)
      
385 - AUDIENCE CHARACTERISTICS (R)
   Indicators
      First - Undefined
         # - Undefined 
      Second - Undefined
         # - Undefined 
   Subfield Codes
      $a - Audience term (R)
      $b - Audience code (R)
      $m - Demographic group term (NR)
      $n - Demographic group code (NR)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (R)

386 - CREATOR/CONTRIBUTOR CHARACTERISTICS (R)
   Indicators
      First - Undefined
         # - Undefined 
      Second - Undefined
         # - Undefined 
   Subfield Codes
      $a - Creator/contributor term (R)
      $b - Creator/contributor code (R)
      $m - Demographic group term (NR)
      $n - Demographic group code (NR)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (R)

388 - TIME PERIOD OF CREATION (R)
   Indicators
      First - Type of time period
         # - No information provided
         1 - Creation of work
         2 - Creation of aggregate work 
      Second - Undefined
         # - Undefined 
   Subfield Codes
      $a - Time period of creation term (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source of term (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (R)


--Series Statement Fields (4XX)--
400 - SERIES STATEMENT/ADDED ENTRY--PERSONAL NAME  (R) [US-LOCAL]
   Indicators
      First - Type of personal name entry element
         0 - Forename
         1 - Surname
         2 - Multiple surname [OBSOLETE]
         3 - Family name
      Second - Pronoun represents main entry
         0 - Main entry not represented by pronoun
         1 - Main entry represented by pronoun
   Subfield Codes
      $a - Personal name (NR)
      $b - Numeration (NR) 
      $c - Titles and other words associated with a name (R)
      $d - Dates associated with a name (NR)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $n - Number of part/section of a work (R)
      $p - Name of part/section of a work (R)
      $q - Fuller form of name (NR) [OBSOLETE]
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $v - Volume number/sequential designation  (NR)
      $x - International Standard Serial Number  (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number  (R)

410 - SERIES STATEMENT/ADDED ENTRY--CORPORATE NAME (R) [US-LOCAL]
   Indicators
      First - Type of corporate name entry element
         0 - Inverted name
         1 - Jurisdiction name
         2 - Name in direct order
      Second - Pronoun represents main entry
         0 - Main entry not represented by pronoun
         1 - Main entry represented by pronoun
   Subfield Codes
      $a - Corporate name or jurisdiction name as entry element (NR)
      $b - Subordinate unit (R)
      $c - Location of meeting (NR)
      $d - Date of meeting or treaty signing (R)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $n - Number of part/section/meeting (R)
      $p - Name of part/section of a work (R)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $v - Volume number/sequential designation  (NR)
      $x - International Standard Serial Number (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

411 - SERIES STATEMENT/ADDED ENTRY--MEETING NAME (R) [US-LOCAL]
   Indicators
      First - Type of meeting name entry element
         0 - Inverted name
         1 - Jurisdiction name
         2 - Name in direct order
      Second - Pronoun represents main entry
         0 - Main entry not represented by pronoun
         1 - Main entry represented by pronoun
   Subfield Codes
      $a - Meeting name or jurisdiction name as entry element (NR)
      $b - Number  [OBSOLETE]
      $c - Location of meeting (NR)
      $d - Date of meeting (NR)
      $e - Subordinate unit (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $n - Number of part/section/meeting (R)
      $p - Name of part/section of a work (R)
      $q - Name of meeting following jurisdiction name entry element (NR)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $v - Volume number/sequential designation  (NR)
      $x - International Standard Serial Number (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

440 - SERIES STATEMENT/ADDED ENTRY--TITLE (R) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Nonfiling characters
         0-9 - Number of nonfiling characters 
   Subfield Codes
      $a - Title (NR)
      $n - Number of part/section of a work (R)
      $p - Name of part/section of a work (R)
      $v - Volume number/sequential designation  (NR)
      $w - Bibliographic record control number (R)
      $x - International Standard Serial Number (NR)
      $0 - Authority record control number (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

490 - SERIES STATEMENT (R)
   Indicators
      First - Specifies whether series is traced
         0 - Series not traced
         1 - Series traced [REDEFINED]
         1 - Series traced differently 
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Series statement (R)
      $l - Library of Congress call number (NR)
      $v - Volume number/sequential designation  (R)
      $x - International Standard Serial Number (R)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)


--Note Fields (Part 1: 50X-53X)--
500 - GENERAL NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - General note (NR)
      $l - Library of Congress call number (SE) [OBSOLETE]
      $x - International Standard Serial Number (SE) [OBSOLETE]
      $z - Source of note information (AM SE) [OBSOLETE]
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

501 - WITH NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - With note (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

502 - DISSERTATION NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Dissertation note (NR)
      $b - Degree type (NR)
      $c - Name of granting institution (NR)  
      $d - Year of degree granted (NR)
      $g - Miscellaneous information (R)
      $o - Dissertation identifier (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

503 - BIBLIOGRAPHIC HISTORY NOTE (R) (BK CF MU) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Bibliographic history note (NR)
      $6 - Linkage (NR)

504 - BIBLIOGRAPHY, ETC. NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Bibliography, etc. note (NR)
      $b - Number of references (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

505 - FORMATTED CONTENTS NOTE (R)
   Indicators
      First - Display constant controller
         0 - Contents
         1 - Incomplete contents
         2 - Partial contents
         8 - No display constant generated
      Second - Level of content designation
         # - Basic
         0 - Enhanced
   Subfield Codes
      $a - Formatted contents note (NR)
      $g - Miscellaneous information (R)
      $r - Statement of responsibility (R)
      $t - Title (R)
      $u - Uniform Resource Identifier (R) 
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

506 - RESTRICTIONS ON ACCESS NOTE (R)
   Indicators
      First - Restriction
         # - No information provided         
         0 - No restrictions
         1 - Restrictions apply
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Terms governing access (NR)
      $b - Jurisdiction (R)
      $c - Physical access provisions (R)
      $d - Authorized users (R)
      $e - Authorization (R)
      $f - Standardized terminology for access restriction (R)
      $u - Uniform Resource Identifier (R)
      $2 - Source of term (NR)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

507 - SCALE NOTE FOR GRAPHIC MATERIAL (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Representative fraction of scale note (NR)
      $b - Remainder of scale note (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

508 - CREATION/PRODUCTION CREDITS NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Creation/production credits note (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

510 - CITATION/REFERENCES NOTE (R)
   Indicators
      First - Coverage/location in source
         0 - Coverage unknown
         1 - Coverage complete
         2 - Coverage is selective
         3 - Location in source not given
         4 - Location in source given
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Name of source (NR)
      $b - Coverage of source (NR)
      $c - Location within source (NR)
      $u - Uniform Resource Identifier (R)
      $x - International Standard Serial Number (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

511 - PARTICIPANT OR PERFORMER NOTE (R)
   Indicators
      First - Display constant controller
         # - No information provided (VM MU) [OBSOLETE]
         0 - No display constant generated
         1 - Cast
         2 - Presenter (VM MU) [OBSOLETE]
         3 - Narrator (VM MU) [OBSOLETE]
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Participant or performer note (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

512 - EARLIER OR LATER VOLUMES SEPARATELY CATALOGED NOTE (SE) (R) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Earlier or later volumes separately cataloged note (NR)
      $6 - Linkage (NR)

513 - TYPE OF REPORT AND PERIOD COVERED NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Type of report (NR)
      $b - Period covered (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

514 - DATA QUALITY NOTE (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Attribute accuracy report (NR)
      $b - Attribute accuracy value (R)
      $c - Attribute accuracy explanation (R)
      $d - Logical consistency report (NR)
      $e - Completeness report (NR)
      $f - Horizontal position accuracy report (NR)
      $g - Horizontal position accuracy value (R)
      $h - Horizontal position accuracy explanation (R)
      $i - Vertical positional accuracy report (NR)
      $j - Vertical positional accuracy value (R)
      $k - Vertical positional accuracy explanation (R)
      $m - Cloud cover (NR)
      $u - Uniform Resource Identifier (R)
      $z - Display note (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

515 - NUMBERING PECULIARITIES NOTE (R)
   Indicators 
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Numbering peculiarities note (NR)
      $z - Source of note information (NR) (SE) [OBSOLETE]
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

516 - TYPE OF COMPUTER FILE OR DATA NOTE (R)
   Indicators
      First - Display constant controller
         # - Type of file
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Type of computer file or data note (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

517 - CATEGORIES OF FILMS NOTE (ARCHIVAL) (VM) (NR) [OBSOLETE]
   Indicators
      First - Fiction specification
         0 - Nonfiction
         1 - Fiction
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Different formats (NR)
      $b - Content descriptors (R)
      $c - Additional animation techniques (R)

518 - DATE/TIME AND PLACE OF AN EVENT NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Date/time and place of an event note (NR)
      $d - Date of event (R)
      $o - Other event information (R)
      $p - Place of event (R)
      $0 - Record control number (R)
      $2 - Source of term (R)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

520 - SUMMARY, ETC. (R)
   Indicators
      First - Display constant controller
         # - Summary
         0 - Subject
         1 - Review
         2 - Scope and content
         3 - Abstract
         4 - Content advice
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Summary, etc. note (NR)
      $b - Expansion of summary note (NR)
      $c - Assigning agency (NR)
      $u - Uniform Resource Identifier (R)
      $z - Source of note information (NR) [OBSOLETE]
      $2 - Source (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

521 - TARGET AUDIENCE NOTE (R)
   Indicators
      First - Display constant controller
         # - Audience
         0 - Reading grade level
         1 - Interest age level
         2 - Interest grade level
         3 - Special audience characteristics
         4 - Motivation interest level
         8 - No display constant generated
      Second - Undefined 
         # - Undefined
   Subfield Codes
      $a - Target audience note (R)
      $b - Source (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

522 - GEOGRAPHIC COVERAGE NOTE (R)
   Indicators
      First - Display constant controller
         # - Geographic coverage
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Geographic coverage note (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

523 - TIME PERIOD OF CONTENT NOTE (NR) (CF) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Time period of content note (NR)
      $b - Dates of data collection note (NR)
      $6 - Linkage (NR)

524 - PREFERRED CITATION OF DESCRIBED MATERIALS NOTE (R)
   Indicators
      First - Display constant controller
         # - Cite as
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Preferred citation of described materials note (NR)
      $2 - Source of schema used (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

525 - SUPPLEMENT NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Supplement note (NR)
      $z - Source of note information (NR) (SE) [OBSOLETE]
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

526 - STUDY PROGRAM INFORMATION NOTE (R)
   Indicators
      First - Display constant controller
         0 - Reading program
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Program name (NR)
      $b - Interest level (NR)
      $c - Reading level (NR)
      $d - Title point value (NR)
      $i - Display text (NR)
      $x - Nonpublic note (R)
      $z - Public note (R)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

527 - CENSORSHIP NOTE (VM) (R) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Censorship note (NR)
      $6 - Linkage (NR)

530 - ADDITIONAL PHYSICAL FORM AVAILABLE NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Additional physical form available note (NR)
      $b - Availability source (NR)
      $c - Availability conditions (NR)
      $d - Order number (NR)
      $u - Uniform Resource Identifier (R)
      $z - Source of note information (NR) (AM CF VM SE) [OBSOLETE]
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

533 - REPRODUCTION NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Type of reproduction (NR)
      $b - Place of reproduction (R)
      $c - Agency responsible for reproduction (R)
      $d - Date of reproduction (NR)
      $e - Physical description of reproduction (NR)
      $f - Series statement of reproduction (R)
      $m - Dates and/or sequential designation of issues reproduced (R)
      $n - Note about reproduction (R)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $7 - Fixed-length data elements of reproduction (NR)
         0 - Type of date/Publication status
         1-4 - Date 1
         5-8 - Date 2
         9-11 - Place of publication, production, or execution
         12 - Frequency
            n - Not applicable
         13 - Regularity
            # - Not applicable
         14 - Form of item
      $8 - Field link and sequence number (R)

534 - ORIGINAL VERSION NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
      First - Specifies presence of series statement on original (BK MP MU VM SE) [OBSOLETE]
         0 - Note excludes series of original
         1 - Note includes series of original
   Subfield Codes
      $a - Main entry of original (NR)
      $b - Edition statement of original (NR)
      $c - Publication, distribution, etc. of original (NR)
      $e - Physical description, etc. of original (NR)
      $f - Series statement of original (R)
      $k - Key title of original (R)
      $l - Location of original (NR)
      $m - Material specific details (NR)
      $n - Note about original (R)
      $o - Other resource identifier (R) 
      $p - Introductory phrase (NR)
      $t - Title statement of original (NR)
      $x - International Standard Serial Number (R)
      $z - International Standard Book Number (R)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

535 - LOCATION OF ORIGINALS/DUPLICATES NOTE (R)
   Indicators 
      First - Additional information about custodian
         0 - Repository (AM) [OBSOLETE]
         1 - Holder of originals
         2 - Holder of duplicates
         3 - Holder of oral tapes (AM) [OBSOLETE]
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Custodian (NR)
      $b - Postal address (R)
      $c - Country (R)
      $d - Telecommunications address (R)
      $g - Repository location code (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)


--Note Fields (Part 2: 53X-58X)--
536 - FUNDING INFORMATION NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Text of note (NR) 
      $b - Contract number (R)
      $c - Grant number (R)
      $d - Undifferentiated number (R)
      $e - Program element number (R)
      $f - Project number (R)
      $g - Task number (R)
      $h - Work unit number (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

537 - SOURCE OF DATA NOTE (NR) (CF) [OBSOLETE]
   Indicators
      First - Display constant controller
         # - No information provided
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Source of data note (NR)
      $6 - Linkage (NR)

538 - SYSTEM DETAILS NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - System details note (NR)
      $i - Display text (NR)
      $u - Uniform Resource Identifier (R)
      $3 - Materials specified  (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

540 - TERMS GOVERNING USE AND REPRODUCTION NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Terms governing use and reproduction (NR)
      $b - Jurisdiction (NR)
      $c - Authorization (NR)
      $d - Authorized users (NR)
      $u - Uniform Resource Identifier (R)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

541 - IMMEDIATE SOURCE OF ACQUISITION NOTE (R)
   Indicators 
      First - Privacy
         # - No information provided
         0 - Private
         1 - Not private
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Source of acquisition (NR)
      $b - Address (NR)
      $c - Method of acquisition (NR)
      $d - Date of acquisition (NR)
      $e - Accession number (NR)
      $f - Owner (NR)
      $h - Purchase price (NR)
      $n - Extent (R)
      $o - Type of unit (R)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

542 - INFORMATION RELATING TO COPYRIGHT STATUS (R)
   Indicators
      First - Privacy
         # - No information provided
         0 - Private
         1 - Not private
      Second - Undefined
         # - Undefined
      $a - Personal creator (NR)
      $b - Personal creator death date (NR)
      $c - Corporate creator (NR)
      $d - Copyright holder (R)
      $e - Copyright holder contact information (R)
      $f - Copyright statement (R)
      $g - Copyright date (NR)
      $h - Copyright renewal date (R)
      $i - Publication date (NR)
      $j - Creation date (NR)
      $k - Publisher (R)
      $l - Copyright status (NR)
      $m - Publication status (NR)
      $n - Note (R)
      $o - Research date (NR)
      $p - Country of publication or creation (R)
      $q - Assigning agency (NR)
      $r - Jurisdiction of copyright assessment (NR)
      $s - Source of information (NR)
      $u - Uniform Resource Identifier (R)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

543 - SOLICITATION INFORMATION NOTE (AM) (R) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Solicitation information note (NR)
      $6 - Linkage (NR)

544 - LOCATION OF OTHER ARCHIVAL MATERIALS NOTE (R)
   Indicators
      First - Relationship
         # - No information provided
         0 - Associated materials
         1 - Related materials
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Custodian (R)
      $b - Address (R)
      $c - Country (R)
      $d - Title (R)
      $e - Provenance (R)
      $n - Note (R)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

545 - BIOGRAPHICAL OR HISTORICAL DATA (R)
   Indicators
      First - Type of data
         # - No information provided
         0 - Biographical sketch
         1 - Administrative history
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Biographical or historical note (NR)
      $b - Expansion (NR)
      $u - Uniform Resource Identifier (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

546 - LANGUAGE NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Language note (NR)
      $b - Information code or alphabet (R)
      $z - Source of note information (NR) (SE) [OBSOLETE]
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

547 - FORMER TITLE COMPLEXITY NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Former title complexity note (NR)
      $z - Source of note information (NR) (SE) [OBSOLETE]
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

550 - ISSUING BODY NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
      First - Existence of additional information (SE) [OBSOLETE]
         0 - Repetitious
         1 - Not repetitious
   Subfield Codes
      $a - Issuing body note (NR)
      $z - Source of note information (NR) (SE) [OBSOLETE]
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

552 - ENTITY AND ATTRIBUTE INFORMATION NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Entity type label (NR)
      $b - Entity type definition and source (NR)
      $c - Attribute label (NR)
      $d - Attribute definition and source (NR)
      $e - Enumerated domain value (R)
      $f - Enumerated domain value definition and source (R)
      $g - Range domain minimum and maximum (NR)
      $h - Codeset name and source (NR)
      $i - Unrepresentable domain (NR)
      $j - Attribute units of measurement and resolution (NR)
      $k - Beginning date and ending date of attribute values (NR)
      $l - Attribute value accuracy (NR)
      $m - Attribute value accuracy explanation (NR)
      $n - Attribute measurement frequency (NR)
      $o - Entity and attribute overview (R)
      $p - Entity and attribute detail citation (R)
      $u - Uniform Resource Identifier (R)
      $z - Display note (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

555 - CUMULATIVE INDEX/FINDING AIDS NOTE (R)
   Indicators
      First - Display constant controller
         # - Indexes
         0 - Finding aids
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Cumulative index/finding aids note (NR)
      $b - Availability source (R)
      $c - Degree of control (NR)
      $d - Bibliographic reference (NR)
      $u - Uniform Resource Identifier (R)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

556 - INFORMATION ABOUT DOCUMENTATION NOTE (R)
   Indicators
      First - Display constant controller
         # - Documentation
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Information about documentation note (NR)
      $z - International Standard Book Number (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

561 - OWNERSHIP AND CUSTODIAL HISTORY (R)
   Indicators
      First - Privacy
         # - No information provided
         0 - Private
         1 - Not private
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - History (NR)
      $b - Time of collation (NR) [OBSOLETE]
      $u - Uniform Resource Identifier (R)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

562 - COPY AND VERSION IDENTIFICATION NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Identifying markings (R)
      $b - Copy identification (R)
      $c - Version identification (R)
      $d - Presentation format (R)
      $e - Number of copies (R)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

563 - BINDING INFORMATION (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Binding note (NR)
      $u - Uniform Resource Identifier (R)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

565 - CASE FILE CHARACTERISTICS NOTE (R)
   Indicators
      First - Display constant controller
         # - File size
         0 - Case file characteristics
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Number of cases/variables (NR)
      $b - Name of variable (R)
      $c - Unit of analysis (R)
      $d - Universe of data (R)
      $e - Filing scheme or code (R)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

567 - METHODOLOGY NOTE (R)
   Indicators
      First - Display constant controller
         # - Methodology
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Methodology note (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

570 - EDITOR NOTE (SE) (R) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Editor note (NR) 
      $z - Source of note information (NR)
      $6 - Linkage (NR)

580 - LINKING ENTRY COMPLEXITY NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Linking entry complexity note (NR)
      $z - Source of note information (NR) [OBSOLETE]
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

581 - PUBLICATIONS ABOUT DESCRIBED MATERIALS NOTE (R)
   Indicators
      First - Display constant controller
         # - Publications
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Publications about described materials note (NR)
      $z - International Standard Book Number (R)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

582 - RELATED COMPUTER FILES NOTE (R) (CF) [OBSOLETE]
   Indicators
      First - Display constant controller
         # - No information provided
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Related computer files note (NR)
      $6 - Linkage (NR)

583 - ACTION NOTE (R)
   Indicators
      First - Privacy
         # - No information provided
         0 - Private
         1 - Not private
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Action (NR)
      $b - Action identification (R)
      $c - Time/date of action (R)
      $d - Action interval (R)
      $e - Contingency for action (R)
      $f - Authorization (R)
      $h - Jurisdiction (R)
      $i - Method of action (R)
      $j - Site of action (R)
      $k - Action agent (R)
      $l - Status (R)
      $n - Extent (R)
      $o - Type of unit (R)
      $u - Uniform Resource Identifier (R)
      $x - Nonpublic note (R)
      $z - Public note (R)
      $2 - Source of term (NR)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

584 - ACCUMULATION AND FREQUENCY OF USE NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Accumulation (R)
      $b - Frequency of use (R)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

585 - EXHIBITIONS NOTE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Exhibitions note (NR)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
586 - AWARDS NOTE (R)
   Indicators
      First - Display constant controller
         # - Awards
         8 - No display constant generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Awards note (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
588 - SOURCE OF DESCRIPTION NOTE (R)
   Indicators
      First - Display constant controller
         # - No information provided
         0 - Source of description
         1 - Latest issue consulted
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Source of description note (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
--59X - LOCAL NOTES--
590 - LOCAL NOTE (BK CF MP MU SE VM MX) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Local note (NR)

590 - RECEIPT DATE NOTE (VM) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Receipt date (NR)
      $b - Provenance (NR)
      $d - Condition of individual reels (NR)
      $d - Origin of safety copy (NR)


--Subject Access Fields (6XX)--
600 - SUBJECT ADDED ENTRY--PERSONAL NAME (R)
   Indicators
      First - Type of personal name entry element
         0 - Forename
         1 - Surname
         2 - Multiple surname [OBSOLETE]
         3 - Family name
      Second - Thesaurus
         0 - Library of Congress Subject Headings
         1 - LC subject headings for children's literature
         2 - Medical Subject Headings
         3 - National Agricultural Library subject authority file
         4 - Source not specified
         5 - Canadian Subject Headings
         6 - Répertoire de vedettes-matière
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Personal name (NR)
      $b - Numeration (NR)
      $c - Titles and other words associated with a name (R)
      $d - Dates associated with a name (NR)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $j - Attribution qualifier (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section of a work (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $q - Fuller form of name (NR)
      $r - Key for music (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $v - Form subdivision (R)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source of heading or term (NR)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

610 - SUBJECT ADDED ENTRY--CORPORATE NAME (R)
   Indicators
      First - Type of corporate name entry element
         0 - Inverted name
         1 - Jurisdiction name
         2 - Name in direct order
      Second - Thesaurus
         0 - Library of Congress Subject Headings
         1 - LC subject headings for children's literature
         2 - Medical Subject Headings 
         3 - National Agricultural Library subject authority file
         4 - Source not specified
         5 - Canadian Subject Headings
         6 - Répertoire de vedettes-matière
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Corporate name or jurisdiction name as entry element (NR)
      $b - Subordinate unit (R)
      $c - Location of meeting (R)
      $d - Date of meeting or treaty signing (R)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section/meeting (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $r - Key for music (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $v - Form subdivision (R)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source of heading or term (NR)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

611 - SUBJECT ADDED ENTRY--MEETING NAME (R)
   Indicators
      First - Type of meeting name entry element
         0 - Inverted name
         1 - Jurisdiction name
         2 - Name in direct order
      Second - Thesaurus
         0 - Library of Congress Subject Headings
         1 - LC subject headings for children's literature
         2 - Medical Subject Headings
         3 - National Agricultural Library subject authority file
         4 - Source not specified
         5 - Canadian Subject Headings
         6 - Répertoire de vedettes-matière
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Meeting name or jurisdiction name as entry element (NR)
      $b - Number (BK CF MP MU SE VM MX) [OBSOLETE]
      $c - Location of meeting (R)
      $d - Date of meeting (NR)
      $e - Subordinate unit (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $j - Relator term (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $n - Number of part/section/meeting (R)
      $p - Name of part/section of a work (R)
      $q - Name of meeting following jurisdiction name entry element (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $v - Form subdivision (R)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source of heading or term (NR)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

630 - SUBJECT ADDED ENTRY--UNIFORM TITLE (R)
   Indicators
      First - Nonfiling characters
         0-9 - Number of nonfiling characters
         # - Nonfiling characters not specified [OBSOLETE]
      Second - Thesaurus
         0 - Library of Congress Subject Headings
         1 - LC subject headings for children's literature
         2 - Medical Subject Headings
         3 - National Agricultural Library subject authority file
         4 - Source not specified
         5 - Canadian Subject Headings
         6 - Répertoire de vedettes-matière
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Uniform title (NR)
      $d - Date of treaty signing (R)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section of a work (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $r - Key for music (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $v - Form subdivision (R)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source of heading or term (NR)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR) 
      $8 - Field link and sequence number (R)

647 - SUBJECT ADDED ENTRY--NAMED EVENT (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Thesaurus
         0 - Library of Congress Subject Headings
         1 - LC subject headings for children's literature
         2 - Medical Subject Headings
         3 - National Agricultural Library subject authority file
         4 - Source not specified
         5 - Canadian Subject Headings
         6 - Répertoire de vedettes-matière
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Named event (NR)
      $c - Location of named event (R)
      $d - Date of named event (NR)
      $g - Miscellaneous information (R)
      $v - Form subdivision (R)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source of heading or term (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

648 - SUBJECT ADDED ENTRY--CHRONOLOGICAL TERM (R)
   Indicators
      First - Undefined
         # - Undefined
      First - Type of date or time period [OBSOLETE]
         # - No information provided [OBSOLETE]
         0 - Date or time period covered or depicted [OBSOLETE]
         1 - Date or time period of creation or origin [OBSOLETE]
      Second - Thesaurus
         0 - Library of Congress Subject Headings
         1 - LC subject headings for children's literature
         2 - Medical Subject Headings
         3 - National Agricultural Library subject authority file
         4 - Source not specified
         5 - Canadian Subject Headings
         6 - Répertoire de vedettes-matière
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Chronological term (NR)
      $v - Form subdivision (R)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source of heading or term (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

650 - SUBJECT ADDED ENTRY--TOPICAL TERM (R)
   Indicators
      First - Level of subject
         # - No information provided
         0 - No level specified
         1 - Primary
         2 - Secondary
      Second - Thesaurus
         0 - Library of Congress Subject Headings
         1 - LC subject headings for children's literature
         2 - Medical Subject Headings
         3 - National Agricultural Library subject authority file
         4 - Source not specified
         5 - Canadian Subject Headings
         6 - Répertoire de vedettes-matière
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Topical term or geographic name as entry element (NR)
      $b - Topical term following geographic name as entry element (NR)
      $c - Location of event (NR)
      $d - Active dates (NR)
      $e - Relator term (NR)
      $g - Miscellaneous information (R)
      $v - Form subdivision (R)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source of heading or term (NR)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

651 - SUBJECT ADDED ENTRY--GEOGRAPHIC NAME (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Thesaurus
         0 - Library of Congress Subject Headings
         1 - LC subject headings for children's literature
         2 - Medical Subject Headings
         3 - National Agricultural Library subject authority file
         4 - Source not specified
         5 - Canadian Subject Headings
         6 - Répertoire de vedettes-matière
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Geographic name (NR)
      $b - Geographic name following place entry element (R) [OBSOLETE]
      $e - Relator term (R)
      $g - Miscellaneous information (R)
      $v - Form subdivision (R)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source of heading or term (NR)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

652 - SUBJECT ADDED ENTRY--REVERSED GEOGRAPHIC (BK MP SE) [OBSOLETE] 
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Geographic name of place element (NR)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)

653 - INDEX TERM--UNCONTROLLED (R)
   Indicators
      First - Level of index term
         # - No information provided
         0 - No level specified
         1 - Primary 
         2 - Secondary
      Second - Type of term or name
         # - No information provided
         0 - Topical term
         1 - Personal name
         2 - Corporate name
         3 - Meeting name
         4 - Chronological term
         5 - Geographic name
         6 - Genre/form term
   Subfield Codes
      $a - Uncontrolled term (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

654 - SUBJECT ADDED ENTRY--FACETED TOPICAL TERMS (R)
   Indicators
      First - Level of subject
         # - No information provided
         0 - No level specified
         1 - Primary 
         2 - Secondary
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Focus term (R)
      $b - Non-focus term (R)
      $c - Facet/hierarchy designation (R)
      $e - Relator term (R)
      $v - Form subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $0 - Authority record control number (R)
      $2 - Source of heading or term (NR)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

655 - INDEX TERM--GENRE/FORM (R)
   Indicators
      First - Type of heading
         # - Basic
         0 - Faceted
      Second - Thesaurus
         0 - Library of Congress Subject Headings
         1 - LC subject headings for children's literature
         2 - Medical Subject Headings
         3 - National Agricultural Library subject authority file
         4 - Source not specified
         5 - Canadian Subject Headings
         6 - Répertoire de vedettes-matière
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Genre/form data or focus term (NR)
      $b - Non-focus term (R)
      $c - Facet/hierarchy designation (R)
      $v - Form subdivision (R)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $0 - Authority record control number (R)
      $2 - Source of term (NR)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

656 - INDEX TERM--OCCUPATION (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Source of term
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Occupation (NR)
      $k - Form (NR)
      $v - Form subdivision (R)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $0 - Authority record control number (R)
      $2 - Source of term (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

657 - INDEX TERM--FUNCTION (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Source of term
         7 - Source specified in subfield $2
   Subfield Codes
      $a - Function (NR)
      $v - Form subdivision (R)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $0 - Authority record control number (R)
      $2 - Source of term (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

658 - INDEX TERM--CURRICULUM OBJECTIVE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Main curriculum objective (NR)
      $b - Subordinate curriculum objective (R)
      $c - Curriculum code (NR)
      $d - Correlation factor (NR)
      $2 - Source of term or code (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

662 - SUBJECT ADDED ENTRY--HIERARCHICAL PLACE NAME (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Country or larger entity (R)
      $b - First-order political jurisdiction (NR)
      $c - Intermediate political jurisdiction (R)
      $d - City (NR)
      $e - Relator term (R)
      $f - City subsection (R)
      $g - Other nonjurisdictional geographic region and feature (R)
      $h - Extraterrestrial area (R)
      $0 - Authority record control number (R)
      $2 - Source of heading or term (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)


--Added Entry Fields (70X-75X)--
700 - ADDED ENTRY--PERSONAL NAME (R)
   Indicators
      First - Type of personal name entry element
         0 - Forename
         1 - Surname
         2 - Multiple surname [OBSOLETE]
         3 - Family name
      Second - Type of added entry
         # - No information provided
         0 - Alternative entry (BK CF MP MU SE MX) [OBSOLETE]
         1 - Secondary entry (BK CF MP MU SE MX) [OBSOLETE]
         1 - Printed on card (VM) [OBSOLETE]
         2 - Analytical entry
         3 - Not printed on card (VM) [OBSOLETE]
   Subfield Codes
      $a - Personal name (NR)
      $b - Numeration (NR)
      $c - Titles and other words associated with a name (R)
      $d - Dates associated with a name (NR)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $i - Relationship information (R)
      $j - Attribution qualifier (R) 
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section of a work (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $q - Fuller form of name (NR)
      $r - Key for music (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $x - International Standard Serial Number (NR)
      $0 - Authority record control number or standard number (R)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

705 - ADDED ENTRY--PERSONAL NAME (PERFORMER) (MU) [OBSOLETE]
   Indicators
      First - Type of personal name entry element
         0 - Forename
         1 - Single surname
         2 - Multiple surname
         3 - Family name
      Second - Type of added entry
         0 - Alternative entry
         1 - Secondary entry
         2 - Analytical entry
   Subfield Codes
      $a - Personal name (NR)
      $b - Numeration (NR)
      $c - Titles and other words associated with a name (R)
      $d - Dates associated with a name (NR)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section of a work (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $r - Key for music (NR)
      $s - Version (NR)
      $t - Title of a work (NR)

710 - ADDED ENTRY--CORPORATE NAME (R)
   Indicators
      First - Type of corporate name entry element
         0 - Inverted name
         1 - Jurisdiction name
         2 - Name in direct order
      Second - Type of added entry
         # - No information provided
         0 - Alternative entry (BK CF MP MU SE MX) [OBSOLETE]
         1 - Secondary entry (BK CF MP MU SE MX) [OBSOLETE]
         1 - Printed on card (VM) [OBSOLETE]
         2 - Analytical entry
         3 - Not printed on card (VM) [OBSOLETE]
   Subfield Codes
      $a - Corporate name or jurisdiction name as entry element (NR)
      $b - Subordinate unit (R)
      $c - Location of meeting (R)
      $d - Date of meeting or treaty signing (R)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $i - Relationship information (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section/meeting (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $r - Key for music (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $x - International Standard Serial Number (NR)
      $0 - Authority record control number or standard number (R)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

711 - ADDED ENTRY--MEETING NAME (R)
   Indicators
      First - Type of meeting name entry element
         0 - Inverted name
         1 - Jurisdiction name
         2 - Name in direct order
      Second - Type of added entry
         # - No information provided
         0 - Alternative entry (BK CF MP MU SE MX) [OBSOLETE]
         1 - Secondary entry (BK CF MP MU SE MX) [OBSOLETE]
         1 - Printed on card (VM) [OBSOLETE]
         2 - Analytical entry
         3 - Not printed on card (VM) [OBSOLETE]
   Subfield Codes
      $a - Meeting name or jurisdiction name as entry element (NR)
      $b - Number (BK CF MP MU SE VM MX) [OBSOLETE]
      $c - Location of meeting (R)
      $d - Date of meeting (NR)
      $e - Subordinate unit (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $i - Relationship information (R)
      $j - Relator term (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $n - Number of part/section/meeting (R)
      $p - Name of part/section of a work (R)
      $q - Name of meeting following jurisdiction name entry element (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $x - International Standard Serial Number (NR)
      $0 - Authority record control number or standard number (R)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

715 - ADDED ENTRY--CORPORATE NAME (PERFORMING GROUP) (MU) [OBSOLETE]
   Indicators
      First - Type of corporate name entry element
         0 - Inverted name
         1 - Jurisdiction name
         2 - Name in direct order
      Second - Type of added entry
         0 - Alternative entry
         1 - Secondary entry
         2 - Analytical entry
   Subfield Codes
      $a - Corporate name or jurisdiction name (NR)
      $b - Subordinate unit (R)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section/meeting (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $r - Key for music (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $u - Nonprinting information (NR)

720 - ADDED ENTRY--UNCONTROLLED NAME (R)
   Indicators
      First - Type of name
         # - Not specified
         1 - Personal
         2 - Other
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Name (NR)
      $e - Relator term (R)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

730 - ADDED ENTRY--UNIFORM TITLE (R)
   Indicators
      First - Nonfiling characters
         0-9 - Number of nonfiling characters
         # - Nonfiling characters not specified [OBSOLETE]
      Second - Type of added entry
         # - No information provided
         0 - Alternative entry (BK CF MP MU SE MX) [OBSOLETE]
         1 - Secondary entry (BK CF MP MU SE MX) [OBSOLETE]
         1 - Printed on card (VM) [OBSOLETE]
         2 - Analytical entry
         3 - Not printed on card (VM) [OBSOLETE]
   Subfield Codes
      $a - Uniform title (NR)
      $d - Date of treaty signing (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $i - Relationship information (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section of a work (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $r - Key for music (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $x - International Standard Serial Number (NR)
      $0 - Authority record control number or standard number (R)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

740 - ADDED ENTRY--UNCONTROLLED RELATED/ANALYTICAL TITLE (R)
   Indicators
      First - Nonfiling characters
         0-9 - Number of nonfiling characters
         # - Nonfiling characters not specified [OBSOLETE]
      Second - Type of added entry
         # - No information provided
         0 - Alternative entry (BK AM CF MP MU) [OBSOLETE]
         1 - Secondary entry (BK AM CF MP MU) [OBSOLETE]
         1 - Printed on card (VM) [OBSOLETE]
         2 - Analytical entry
         3 - Not printed on card (VM) [OBSOLETE]
   Subfield Codes
      $a - Uncontrolled related/analytical title (NR)
      $h - Medium (NR)
      $n - Number of part/section of a work (R)
      $p - Name of part/section of a work (R)
      $5 - Institution to which field applies (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

751 - ADDED ENTRY--GEOGRAPHIC NAME (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Geographic name (NR)
      $e - Relator term (R)
      $0 - Authority record control number (R)
      $2 - Source of heading or term (NR) 
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

752 - ADDED ENTRY--HIERARCHICAL PLACE NAME (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Country or larger entity (R)
      $b - First-order political jurisdiction (NR)
      $c - Intermediate political jurisdiction (R)
      $d - City (NR)
      $e - Relator term (R)
      $f - City subsection (R)
      $g - Other nonjurisdictional geographic region and feature (R)
      $h - Extraterrestrial area (R)
      $0 - Authority record control number (R)
      $2 - Source of heading or term (NR)
      $4 - Relator code (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

753 - SYSTEM DETAILS ACCESS TO COMPUTER FILES (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Make and model of machine (NR)
      $b - Programming language (NR)
      $c - Operating system (NR)
      $0 - Authority record control number or standard number (R)
      $2 - Source of term (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

754 - ADDED ENTRY--TAXONOMIC IDENTIFICATION (R)
   Indicators 
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Taxonomic name (R)
      $c - Taxonomic category (R)
      $d - Common or alternative name (R)
      $x - Non-public note (R)
      $z - Public note (R)
      $0 - Authority record control number (R)
      $2 - Source of taxonomic identification (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

755 - ADDED ENTRY--PHYSICAL CHARACTERISTICS (R) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Access term (NR)
      $x - General subdivision (R)
      $y - Chronological subdivision (R)
      $z - Geographic subdivision (R)
      $2 - Source of term (NR) 
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)


--Linking Entry Fields (76X-78X)--
760 - MAIN SERIES ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - Main series
         8 - No display constant generated
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $q - Parallel title (NR) (BK SE) [OBSOLETE]
      $s - Uniform title (NR)
      $t - Title (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

762 - SUBSERIES ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - Has subseries
         8 - No display constant generated
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $q - Parallel title (NR) (BK SE) [OBSOLETE]
      $s - Uniform title (NR)
      $t - Title (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

765 - ORIGINAL LANGUAGE ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - Translation of
         8 - No display constant generated
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $q - Parallel title (NR) (BK SE) [OBSOLETE]
      $r - Report number (R)
      $s - Uniform title (NR)
      $t - Title (NR)
      $u - Standard Technical Report Number (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $z - International Standard Book Number (R)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name 
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

767 - TRANSLATION ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - Translated as
         8 - No display constant generated
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR) 
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $q - Parallel title (NR) (BK SE) [OBSOLETE]
      $r - Report number (R)
      $s - Uniform title (NR)
      $t - Title (NR)
      $u - Standard Technical Report Number (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $z - International Standard Book Number (R)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

770 - SUPPLEMENT/SPECIAL ISSUE ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - Has supplement
         8 - No display constant generated
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR) 
      $i - Relationship information (R)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $q - Parallel title (NR) (BK SE) [OBSOLETE]
      $r - Report number (R)
      $s - Uniform title (NR)
      $t - Title (NR)
      $u - Standard Technical Report Number (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $z - International Standard Book Number (R)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

772 - SUPPLEMENT PARENT ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - Supplement to
         0 - Parent
         8 - No display constant generated
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $q - Parallel title (NR) (BK SE) [OBSOLETE]
      $r - Report number (R)
      $s - Uniform title (NR)
      $t - Title (NR)
      $u - Standard Technical Report Number (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $z - International Stan dard Book Number (R)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

773 - HOST ITEM ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - In
         8 - No display constant generated
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $p - Abbreviated title (NR)
      $q - Enumeration and first page (NR)
      $r - Report number (R)
      $s - Uniform title (NR)
      $t - Title (NR)
      $u - Standard Technical Report Number (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $z - International Standard Book Number (R)
      $3 - Materials specified (NR)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

774 - CONSTITUENT UNIT ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - Constituent unit
         8 - No display constant generated
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $r - Report number (R)
      $s - Uniform title (NR)
      $t - Title (NR)
      $u - Standard Technical Report Number (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $z - International Standard Book Number (R)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

775 - OTHER EDITION ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - Other edition available
         8 - No display constant generated
      Second - Edition entry same as main entry or title (SE) [OBSOLETE]
         0 - Entry not the same
         1 - Entry is the same as title
         2 - Entry is the same as main entry and title
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $e - Language code (NR)
      $f - Country code (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $q - Parallel title (NR) (BK SE) [OBSOLETE]
      $r - Report number (R)
      $s - Uniform title (NR)
      $t - Title (NR)
      $u - Standard Technical Report Number (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $z - International Standard Book Number (R)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

776 - ADDITIONAL PHYSICAL FORM ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - Available in another form
         8 - No display constant generated
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $q - Parallel title (NR) (BK SE) [OBSOLETE]
      $r - Report number (R)
      $s - Uniform title (NR)
      $t - Title (NR)
      $u - Standard Technical Report Number (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $z - International Standard Book Number (R)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name 
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

777 - ISSUED WITH ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - Issued with
         8 - No display constant generated
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $q - Parallel title (NR) (BK SE) [OBSOLETE]
      $s - Uniform title (NR)
      $t - Title (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

780 - PRECEDING ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Type of relationship
         0 - Continues
         1 - Continues in part
         2 - Supersedes
         3 - Supersedes in part
         4 - Formed by the union of ... and ...
         5 - Absorbed
         6 - Absorbed in part
         7 - Separated from
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $q - Parallel title (NR) (BK SE) [OBSOLETE]
      $r - Report number (R)
      $s - Uniform title (NR)
      $t - Title (NR)
      $u - Standard Technical Report Number (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $z - International Standard Book Number (R)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

785 - SUCCEEDING ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Type of relationship
         0 - Continued by
         1 - Continued in part by
         2 - Superseded by
         3 - Superseded in part by
         4 - Absorbed by
         5 - Absorbed in part by
         6 - Split into ... and ...
         7 - Merged with ... to form ...
         8 - Changed back to
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $q - Parallel title (NR) (BK SE) [OBSOLETE]
      $r - Report number (R)
      $s - Uniform title (NR)
      $t - Title (NR)
      $u - Standa rd Technical Report Number (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $z - International Standard Book Number (R)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

786 - DATA SOURCE ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - Data source
         8 - No display constant generated
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $j - Period of content (NR)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $p - Abbreviated title (NR)
      $r - Report number (R)
      $s - Uniform title (NR)
      $t - Title (NR)
      $u - Standard Technical Report Number (NR)
      $v - Source Contribution (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $z - International Standard Book Number (R)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)

787 - OTHER RELATIONSHIP ENTRY (R)
   Indicators
      First - Note controller
         0 - Display note
         1 - Do not display note
      Second - Display constant controller
         # - Related item
         8 - No display constant generated
   Subfield Codes
      $a - Main entry heading (NR)
      $b - Edition (NR)
      $c - Qualifying information (NR)
      $d - Place, publisher, and date of publication (NR)
      $g - Related parts (R)
      $h - Physical description (NR)
      $i - Relationship information (R)
      $k - Series data for related item (R)
      $m - Material-specific details (NR)
      $n - Note (R)
      $o - Other item identifier (R)
      $r - Report number (R)
      $s - Uniform title (NR)
      $t - Title (NR)
      $u - Standard Technical Report Number (NR)
      $w - Record control number (R)
      $x - International Standard Serial Number (NR)
      $y - CODEN designation (NR)
      $z - International Standard Book Number (R)
      $4 - Relationship code (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of main entry heading
         1 - Form of name
         2 - Type of record
         3 - Bibliographic level
      $8 - Field link and sequence number (R)


--Series Added Entry Fields (80X-830)--
800 - SERIES ADDED ENTRY--PERSONAL NAME (R)
   Indicators
      First - Type of personal name entry element
         0 - Forename
         1 - Surname
         3 - Family name
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Personal name (NR)
      $b - Numeration (NR)
      $c - Titles and other words associated with a name (R)
      $d - Dates associated with a name (NR)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $j - Attribution qualifier (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section of a work  (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $q - Fuller form of name (NR)
      $r - Key for music (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $v - Volume/sequential designation  (NR)
      $w - Bibliographic record control number (R)
      $x - International Standard Serial Number (NR)
      $0 - Authority record control number or standard number (R)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $5 - Institution to which field applies (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of record
         1 - Bibliographic level
      $8 - Field link and sequence number (R)

810 - SERIES ADDED ENTRY--CORPORATE NAME (R)
   Indicators
      First - Type of corporate name entry element
         0 - Inverted name
         1 - Jurisdiction name
         2 - Name in direct order
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Corporate name or jurisdiction name as entry element (NR)
      $b - Subordinate unit (R)
      $c - Location of meeting (R)
      $d - Date of meeting or treaty signing (R)
      $e - Relator term (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section/meeting (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $r - Key for music (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $v - Volume/sequential designation (NR)
      $w - Bibliographic record control number (R)
      $x - International Standard Serial Number (NR)
      $0 - Authority record control number or standard number (R)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $5 - Institution to which field applies (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of record
         1 - Bibliographic level
      $8 - Field link and sequence number (R)

811 - SERIES ADDED ENTRY--MEETING NAME (R)
   Indicators
      First - Type of meeting name entry element
         0 - Inverted name
         1 - Jurisdiction name
         2 - Name in direct order
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Meeting name or jurisdiction name as entry element (NR)
      $c - Location of meeting (R)
      $d - Date of meeting (NR)
      $e - Subordinate unit (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $j - Relator term (R)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $n - Number of part/section/meeting (R)
      $p - Name of part/section of a work (R)
      $q - Name of meeting following jurisdiction name entry element (NR)
      $s - Version (NR)
      $t - Title of a work (NR)
      $u - Affiliation (NR)
      $v - Volume/sequential designation (NR)
      $w - Bibliographic record control number (R)
      $x - International Standard Serial Number (NR)
      $0 - Authority record control number or standard number (R)
      $3 - Materials specified (NR)
      $4 - Relator code (R)
      $5 - Institution to which field applies (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of record
         1 - Bibliographic level
      $8 - Field link and sequence number (R)

830 - SERIES ADDED ENTRY--UNIFORM TITLE (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Nonfiling characters
         0-9 - Number of nonfiling characters 
   Subfield Codes
      $a - Uniform title (NR)
      $d - Date of treaty signing (R)
      $f - Date of a work (NR)
      $g - Miscellaneous information (R)
      $h - Medium (NR)
      $k - Form subheading (R)
      $l - Language of a work (NR)
      $m - Medium of performance for music (R)
      $n - Number of part/section of a work (R)
      $o - Arranged statement for music (NR)
      $p - Name of part/section of a work (R)
      $r - Key for music (NR)
      $s - Version (NR)
      $t - Title of a work (NR) 
      $v - Volume/sequential designation (NR)
      $w - Bibliographic record control number (R)
      $x - International Standard Serial Number (NR)
      $0 - Authority record control number or standard number (R)
      $3 - Materials specified (NR)
      $5 - Institution to which field applies (R)
      $6 - Linkage (NR)
      $7 - Control subfield (NR)
         0 - Type of record
         1 - Bibliographic level
      $8 - Field link and sequence number (R)

840 - SERIES ADDED ENTRY--TITLE (R) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Nonfiling characters
         0-9 - Number of nonfiling characters 
   Subfield Codes
      $a - Title (NR)
      $h - Medium (NR)
      $v - Volume/sequential designation (NR)


--Holdings, Location, Alternate Graphics, etc. Fields (841-88X)--
841 - HOLDINGS CODED DATA VALUES (NR)

842 - TEXTUAL PHYSICAL FORM DESIGNATOR (NR)

843 - REPRODUCTION NOTE (R)

844 - NAME OF UNIT (NR)

845 - TERMS GOVERNING USE AND REPRODUCTION NOTE (R)

850 - HOLDING INSTITUTION (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Holding institution (R)
      $b - Holdings (NR) (MU VM SE) [OBSOLETE]
      $d - Inclusive dates (NR) (MU VM SE) [OBSOLETE]
      $e - Retention statement (NR) (CF MU VM SE) [OBSOLETE]
      $8 - Field link and sequence number (R)

851 - LOCATION (R) [OBSOLETE]
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Name (custodian or owner) (NR)
      $b - Institutional division (NR)
      $c - Street address (NR)
      $d - Country (NR)
      $e - Location of units (NR)
      $f - Item number (NR)
      $g - Repository location code (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)

852 - LOCATION (R)
   Indicators
      First - Shelving scheme
         # - No information provided
         0 - Library of Congress classification
         1 - Dewey Decimal classification
         2 - National Library of Medicine classification
         3 - Superintendent of Documents classification
         4 - Shelving control number
         5 - Title
         6 - Shelved separately
         7 - Source specified in subfield $2
         8 - Other scheme
      Second - Shelving order
         # - No information provided
         0 - Not enumeration
         1 - Primary enumeration
         2 - Alternative enumeration
   Subfield Codes
      $a - Location (NR)
      $b - Sublocation or collection (R)
      $c - Shelving location (R)
      $d - Former shelving location (R)
      $e - Address (R)
      $f - Coded location qualifier (R)
      $g - Non-coded location qualifier (R)
      $h - Classification part (NR)
      $i - Item part (R)
      $j - Shelving control number (NR)
      $k - Call number prefix (R)
      $l - Shelving form of title (NR)
      $m - Call number suffix (R)
      $n - Country code (NR)
      $p - Piece designation (NR)
      $q - Piece physical condition (NR)
      $s - Copyright article-fee code (R)
      $t - Copy number (NR)
      $u - Uniform Resource Identifier  (R)
      $x - Nonpublic note (R)
      $z - Public note (R)
      $2 - Source of classification or shelving scheme (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Sequence number (NR)

853 - CAPTIONS AND PATTERN--BASIC BIBLIOGRAPHIC UNIT (R)

854 - CAPTIONS AND PATTERN--SUPPLEMENTARY MATERIAL (R)

855 - CAPTIONS AND PATTERN--INDEXES (R)

856 - ELECTRONIC LOCATION AND ACCESS (R)
   Indicators
      First - Access method
         # - No information provided
         0 - Email
         1 - FTP
         2 - Remote login (Telnet)
         3 - Dial-up
         4 - HTTP
         7 - Method specified in subfield $2
      Second - Relationship
         # - No information provided
         0 - Resource
         1 - Version of resource
         2 - Related resource
         8 - No display constant generated
   Subfield Codes
      $a - Host name (R)
      $b - Access number (R)
      $c - Compression information (R)
      $d - Path (R)
      $f - Electronic name (R)
      $g - Uniform Resource Name (R) [OBSOLETE]
      $h - Processor of request (NR)
      $i - Instruction (R)
      $j - Bits per second (NR)
      $k - Password (NR)
      $l - Logon (NR)
      $m - Contact for access assistance (R)
      $n - Name of location of host (NR)
      $o - Operating system (NR)
      $p - Port (NR)
      $q - Electronic format type (NR)
      $r - Settings (NR)
      $s - File size (R)
      $t - Terminal emulation (R)
      $u - Uniform Resource Identifier (R)
      $v - Hours access method available (R)
      $w - Record control number (R)
      $x - Nonpublic note (R)
      $y - Link text (R)
      $z - Public note (R)
      $2 - Access method (NR)
      $3 - Materials specified (NR)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)

863 - ENUMERATION AND CHRONOLOGY--BASIC BIBLIOGRAPHIC UNIT (R)

864 - ENUMERATION AND CHRONOLOGY--SUPPLEMENTARY MATERIAL (R)

865 - ENUMERATION AND CHRONOLOGY--INDEXES (R)

866 - TEXTUAL HOLDINGS--BASIC BIBLIOGRAPHIC UNIT (R)

867 - TEXTUAL HOLDINGS--SUPPLEMENTARY MATERIAL (R)

868 - TEXTUAL HOLDINGS--INDEXES (R)

870 - VARIANT PERSONAL NAME (SE) [OBSOLETE]

871 - VARIANT CORPORATE NAME (SE) [OBSOLETE]

872 - VARIANT CONFERENCE OR MEETING NAME (SE) [OBSOLETE]

873 - VARIANT UNIFORM TITLE HEADING (SE) [OBSOLETE]

876 - ITEM INFORMATION--BASIC BIBLIOGRAPHIC UNIT (R)

877 - ITEM INFORMATION--SUPPLEMENTARY MATERIAL (R)

878 - ITEM INFORMATION--INDEXES (R)

880 - ALTERNATE GRAPHIC REPRESENTATION (R)
   Indicators
      First - Same as associated field
      Second - Same as associated field
   Subfield Codes
      $6 - Linkage (NR)
      $a-z Same as associated field
      $0-5 Same as associated field
      $7-9 Same as associated field

882 - REPLACEMENT RECORD INFORMATION (NR)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Replacement title (R)
      $i - Explanatory text (R)
      $w - Replacement bibliographic record control number (R)
      $6 - Linkage (NR)
      $8 - Field link and sequence number (R)
	  
883 - MACHINE-GENERATED METADATA PROVENANCE (R)
   Indicators
      First - Method of machine assignment
         # - No information provided/not applicable
         0 - Fully machine-generated
         1 - Partially machine-generated
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Generation process (NR)
      $c - Confidence value (NR)
      $d - Generation date (NR)
      $q - Generation agency (NR)
      $x - Validity end date (NR)
      $u - Uniform Resource Identifier (NR)
      $w - Bibliographic record control number (R)
      $0 - Authority record control number or standard number (R)
      $8 - Field link and sequence number (R)

884 - DESCRIPTION CONVERSION INFORMATION (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Conversion process (NR)
      $g - Conversion date (NR)
      $k - Identifier of source metadata (NR)
      $q - Conversion agency (NR)
      $u - Uniform Resource Identifier (R)

885 - MATCHING INFORMATION (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Matching information (NR)
      $b - Status of matching and its checking (NR)
      $c - Confidence value (NR)
      $d - Generation date (NR)
      $w - Record control number (R)
      $x - Nonpublic note (R)
      $z - Public note (R)
      $0 - Authority record control number or standard number (R)
      $2 - Source (NR)
      $5 - Institution to which field applies (NR)

886 - FOREIGN MARC INFORMATION FIELD (R)
   Indicators
      First - Type of field
         0 - Leader
         1 - Variable control fields (002-009)
         2 - Variable data fields (010-999)
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Tag of the foreign MARC field (NR)
      $b - Content of the foreign MARC field (NR)
      $2 - Source of data (NR)
      $a-z - Foreign MARC subfield (R)
      $0-9 - Foreign MARC subfield (R)

887 - NON-MARC INFORMATION FIELD (R)
   Indicators
      First - Undefined
         # - Undefined
      Second - Undefined
         # - Undefined
   Subfield Codes
      $a - Content of non-MARC field (NR)
      $2 - Source of data (NR)   