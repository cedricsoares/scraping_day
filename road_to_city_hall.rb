

require 'rubygems'
require 'nokogiri'
require 'open-uri'



#fonction qui récupère l'e-mail de contact sur une age de ville 
def get_the_email_of_a_townhal_from_its_webpage(url_page)

	town_email =  Array.new #récupère le mail sur chaque page de ville 

	page_with_mail = Nokogiri::HTML(open(url_page))
	town_email = page_with_mail.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
	puts "Voici l'email de contact de la ville #{town_email}"
end



#fonction qui récupère toutes les noms des villes et les encres associées 
def get_all_the_urls_of_val_doise_townhalls(url_directory)

	town_relative_urls = Array.new #récupère les urls relarives de chaque ville


	page_with_urls = Nokogiri::HTML(open(url_directory))
	town_relative_urls = page_with_urls.css('//a.lientxt')
	town_relative_urls.each do |town| 

	puts "Nom de la ville: #{town.text}\t""ancre: #{town['href']}"
	end
end 

  
#fonction qui récupère les e-mail par noms de villes 
def get_email_of_all_town(url_directory)


#déclaration des 
	town_relative_urls = Array.new #récupère les urls relarives de chaque ville
	town_email =  Array.new #récupère le mail sur chaque page de ville 
	complete_urls = Array.new #urls reconstuites avec http:// ...
	town_names = Array.new #récupère le nom des villes
	all_towns = Array.new #Array avec tous les hash 


# récupération du tableau des liens relatifs des villes 
	page_with_urls = Nokogiri::HTML(open(url_directory))
	town_relative_urls = page_with_urls.css('//a.lientxt')
	


# récupération des urls complètes des villes dans array_of_town_pages
	town_relative_urls.each do |town_url_suffix|
		town_complete_url="http://annuaire-des-mairies.com/"+town_url_suffix['href'].delete_prefix(".")
		complete_urls.push town_complete_url
		town_names.push town_url_suffix.text  
	end
		 

#récupération des e-mails villes dans un hash_email_of_town 
	complete_urls.each do |url_town|
	page_of_town = Nokogiri::HTML(open(url_town))
	town_email.push page_of_town.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
	end

#création des hashs par ville avec remplissage avec nom et e-mail 
for i in 0..town_names.length 
	all_towns.push({"name" => town_names[i], "email" => town_email[i]})
	end 

#affichage du Array final 
puts "Voici le tableau qui associe chaque ville à son e-mail de contact"
puts  all_towns 

end


#affichage des résultats des différentes fonctions 

print  "-" * 10
puts " "

get_the_email_of_a_townhal_from_its_webpage("http://annuaire-des-mairies.com/95/vaureal.html")

print  "-" * 10
puts " "


get_all_the_urls_of_val_doise_townhalls("http://annuaire-des-mairies.com/val-d-oise.html")


print "_" * 10
puts " "


get_email_of_all_town("http://annuaire-des-mairies.com/val-d-oise.html")

print "_" * 10
puts " "
