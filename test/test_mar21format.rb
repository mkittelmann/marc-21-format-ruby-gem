require 'minitest/autorun'

class TestMARC21Format < Test::Unit::TestCase
  
  def setup
    begin
      @marc = MARC21Format.new
    rescue Exception => e
      @marc = MARC21Format.new( 'marc21.txt' )
    end
  end

  def test_load_format_from_web
    assert marc = MARC21Format.new
  end

  def test_load_format_from_file
    assert marc = MARC21Format.new( 'marc21.txt' )
    assert marc.respond_to? 'marc'
  end
  
  def test_get_tags_with_indicators
    assert marc.get_tags_with_indicators
  end
  
  def test_get_tags_without_indicators
    assert marc.get_tags_without_indicators
  end 

  
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


end