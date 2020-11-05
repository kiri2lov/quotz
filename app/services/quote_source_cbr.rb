class QuoteSourceCbr
  def fetch
    res = RestClient.get "http://www.cbr.ru/scripts/XML_daily.asp"
    Nokogiri::XML(res.body).at_css("Valute[ID='R01235']/Value").text.sub(",", ".").to_f
  end
end
