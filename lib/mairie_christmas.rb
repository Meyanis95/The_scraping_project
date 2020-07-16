require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_townhall_urls
    url = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    all_town_urls = Array.new
    i = 0
    url.css('tr//td//p//a/@href').each do |node|
        all_town_urls[i] = "http://annuaire-des-mairies.com" + node.to_s[1..-1]
        i += 1
    end
    return all_town_urls
end


def get_townhall_email(townhall_url)
    #Création de l'array final
    begin    
        doc = Nokogiri::HTML(open(townhall_url))
        town_name = doc.xpath("/html/body/div/main/section[1]/div/div/div/h1").text[0..-8]
        town_mail = doc.xpath("/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]").text 
        #Création du hash pour ranger le nom de la ville et son mail
        town = Hash.new 
        town[town_name] = town_mail
        puts town
        return town
    rescue 
        puts "Aie un URL était pas bon"
    end
end 

def get_final
    all_urls = get_townhall_urls
    all_mails = Array.new
    all_urls.each do |url|
        #get_townhall_email(url)
        town = get_townhall_email(url)
        all_mails.append(town)
    end
    puts "Et voilà liste finale :"
    print all_mails
end

get_final

