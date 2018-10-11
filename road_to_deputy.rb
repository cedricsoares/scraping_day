
require 'rubygems'
require 'pry'
require 'nokogiri'
require 'open-uri'

def get_deputy_contacts(url)
	deputies_url = Array.new 
	deputies_identity = Array.new
	deputies_first_name = Array.new
	deputies_last_name = Array.new
	deputies_contacts = Hash.new 


	i = 0

	doc = Nokogiri::HTML(open(url))
	while i < 577
		deputies_identity.push doc.css("tr[#{i}] td[1] a").text.split(' ')
		deputies_first_name.push deputies_identity[i][1]
		deputies_last_name.push deputies_identity[i][2]
		deputies_url.push doc.css("tr[#{i}] td[1] a")

		i += 1
	end


puts deputies_url

end 


get_deputy_contacts("http://www2.assemblee-nationale.fr/deputes/liste/tableau")



#("/html/body/div[3]/div/div/section/div/article/div[3]/div/div/table/tbody/tr[#{i}]/td[1]/a").text.split(' ')
#
#tr.odd:nth-child(1) > td:nth-child(1) > a:nth-child(1)
#
