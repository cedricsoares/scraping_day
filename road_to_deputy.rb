
require 'rubygems'
require 'pry'
require 'nokogiri'
require 'open-uri'

def get_deputy_contacts(url)
	deputies_url = Array.new #récupère les url des pages de chaque député 
	deputies_identity = Array.new #récupère l'identitée complète de chaque député (Prénom + Nom)
	deputies_first_name = Array.new #récupère le prénon de chaque député 
	deputies_last_name = Array.new #récupère le nom de famille de chaque député 
	deputies_email = Array.new #récupère l'e-mail de chaque député 
	deputies_contacts = Array.new #ensemnble des coordonnées des députés classéee par Prénom, Nom et e-mail


	i = 0

	doc = Nokogiri::HTML(open(url))
	while i < 577

	
		deputies_identity.push doc.css("tr[#{i}] td[1] a").text.split(' ')
		deputies_first_name.push deputies_identity[i][1]
		deputies_last_name.push deputies_identity[i][2]
		deputies_url.push "http://www2.assemblee-nationale.fr#{doc.xpath("//tr[#{i}]/td[1]/a/@href")}"

		url_to_check = Nokogiri::HTML(open(deputies_url[i]))
		

		deputies_email.push url_to_check.xpath("//section/dl/dd[1]/a/@href").text

		deputies_contacts.push({"first_name" => deputies_first_name[i], "last_name" => deputies_last_name[i], "e-mail" => deputies_email[i]})

		

		i += 1

	end

	puts deputies_contacts 


end 


get_deputy_contacts("http://www2.assemblee-nationale.fr/deputes/liste/tableau")




#/html/body/div[3]/div/div/div/section[2]/div/div/div/article/div[3]/section/dl/dd[1]/a
#/html/body/div[3]/div/div/div/section[2]/div/div/div/article/div[3]/section/dl/dd[1]/a
