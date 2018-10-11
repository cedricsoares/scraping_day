
require 'rubygems'
require 'nokogiri'
require 'open-uri'


def store_currencies_and_values(url)
	all_currencies = Array.new
	
	i = 0
	
	doc = Nokogiri::HTML(open(url))
	
	while i < doc.css('td.text-center').size 
	
	all_currencies.push({"currency" => doc.xpath("/html/body/div[2]/div/div[1]/div[2]/div[3]/div[2]/table/tbody/tr[#{i}]/td[2]/a").text , "value" => doc.xpath("/html/body/div[2]/div/div[1]/div[2]/div[3]/div[2]/table/tbody/tr[#{i}]/td[5]/a").text})
	
	i += 1
	sleep(3600)
	end
	puts all_currencies
end

store_currencies_and_values("https://coinmarketcap.com/all/views/all/")


