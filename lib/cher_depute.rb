require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_depute_urls
    url = Nokogiri::HTML(open("http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
    all_depute_urls = Array.new
    i = 0
    url.css("div[@class = 'clearfix col-container']//ul//li//a/@href").each do |node|
        all_depute_urls[i] = "http://www2.assemblee-nationale.fr" + node.to_s
        i += 1
    end
    return all_depute_urls
end


def get_depute_infos(all_depute_url)
    #Création de l'array final
    begin    
        doc = Nokogiri::HTML(open(all_depute_url))
        mail = doc.xpath("//*[@id='haut-contenu-page']/article/div[3]/div/dl/dd[4]/ul/li[2]/a").text
        first_name = mail.split('.')[0].capitalize
        last_name = mail.split('.')[1].split('@')[0].capitalize
        #Création du hash pour ranger le nom du depute et son mail
        depute = Hash.new 
        depute["email"] = mail
        depute["first_name"] = first_name
        depute["last_name"] = last_name
        puts "Le député #{first_name} #{last_name} a été ajouté à la liste"
        return depute
    rescue 
        puts "Aie un URL était pas bon"
    end
end 

def get_final
    all_urls = get_depute_urls
    all_depute = Array.new
    all_urls.each do |url|
        #get_townhall_email(url)
        depute = get_depute_infos(url)
        all_depute.append(depute)
    end
    puts "Et voilà liste finale :"
    print all_depute
end

get_final