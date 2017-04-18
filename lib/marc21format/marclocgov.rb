class MARCLOCGOV
  attr_reader :complete_marc_format_str

  def crawl 
    url = 'https://www.loc.gov/marc/bibliographic/ecbdlist.html'    
    response = RestClient::Request.execute( { method: :get, url: url, verify_ssl: false } )
    if response.code == 200
      page = Nokogiri::HTML( response.body )
      @complete_marc_format_str = page.xpath('//pre/text()').to_html
    else 
      abort 'Error occured: ' + response.code.to_s
    end
    File.open( Dir.pwd + '_marc21-test.txt', 'w:utf-8' ) { |f| f.write @complete_marc_format_str }
    @complete_marc_format_str
  end
  
end
