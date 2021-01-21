require 'nokogiri'
require 'open-uri'
require 'colorize'


def get_townhall_email
    
    puts "Veuillez entrer le numèro de votre departement rechercher :".colorize(:color => :red)
    print "> ".blue
    departement_search = gets.chomp.to_s
    puts "Veuillez entrer la ville rechercher sans majuscule:".colorize(:color => :red)
    print "> ".blue
    town_search = gets.chomp.to_s
    array_name =[]
    array_email =[]
    townhall_hash = []
    
    page = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/#{departement_search}/#{town_search}.html"))
    town = page.xpath('//html/body/div[1]/main/section[2]/div/table/tbody/tr[1]/td[2]')
    town_email = page.xpath('//html/body/div[1]/main/section[2]/div/table/tbody/tr[4]/td[2]')
    town.each do |name_town|
        array_name << name_town.text
    end
    town_email.each do |email_town|
        array_email << email_town.text
    end
    @townhall_hash = Hash[array_name.zip array_email]
end

def perform
    system('clear')
    puts "      DataInDeep - DirectoryTown by D1sh ".red
    puts " |===============================================|".blue
    puts "      [1] EXECUTE".green
    puts " |===============================================|".blue
    puts "      [2] EXIT".green
    puts " |===============================================|".blue
    user_choice = gets.chomp.to_i

    if user_choice == 1
      system('clear')
      get_townhall_email()
      puts "Voici l'adresse et l'e-mail recherché:".red
      print "> ".blue
      puts @townhall_hash
      sleep(2)
      puts ""
      puts "Souhaitez vous faire une autre recherche ?(y / n)".red
      print "> ".blue
      if gets.chomp.to_s == "y"
        perform()
      else
      end
    end
end

array_url = []
page = Nokogiri::HTML(URI.open("http://www.annuaire-des-mairies.com/val-d-oise.html"))
moncul = page.css('a=href')
moncul.each do |url|
    array_url << url.text
end
puts array_url