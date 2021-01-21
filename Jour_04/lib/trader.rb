require 'nokogiri'
require 'open-uri'
require 'colorize'

URL = "https://coinmarketcap.com/all/views/all/"

#===================ON TEST LE LIEN=============================================#
def test_link
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  return nil if !page
  puts "Etape 1 : OK".green if page
  sleep(2)
end

#=====================ON RECHERCHE LES NOMS=======================================#
def cryto_name
  @array_name = []
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  name_of_crypto = page.xpath('//*[@id="__next"]//tr//td[3]')
  name_of_crypto.each do |name|
    @array_name << name.text
  end
  return nil if !name_of_crypto.any?
  puts "Etape 2 : OK".green if name_of_crypto.any? 
end

#=====================ON RECHERCHE LES VALEURS======================================#
def crypto_value
 @array_value = [] 
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
  value_of_crypto = page.xpath('//*[@id="__next"]//tr//td[5]')
  value_of_crypto.each do |value|
    @array_value << value.text
  end
  return nil if !value_of_crypto.any?
  puts "Etape 3 : OK".green if value_of_crypto.any?
end

#=====================ON CREER NOTRE HASH UNE FOIS============================================#

def my_final_hash_one
    test_link()
    cryto_name()
    crypto_value()
    array_value_of_crypto = @array_value.map {|dollars| dollars.gsub("$", '')}
    mon_hash = Hash[@array_name.zip array_value_of_crypto]
    mon_hash.each do |name_crypto , value_crypto|
     final_crypto = {name_crypto => value_crypto.delete(",").to_f}
     puts final_crypto
     sleep(0.01)    
    end
end

#=====================ON CREER NOTRE HASH ET S'ACTUALISE============================================#
def my_final_hash
  while true
    test_link()
    cryto_name()
    crypto_value()
    array_value_of_crypto = @array_value.map {|dollars| dollars.gsub("$", '')}
    mon_hash = Hash[@array_name.zip array_value_of_crypto]
    mon_hash.each do |name_crypto , value_crypto|
     final_crypto = {name_crypto => value_crypto.delete(",").to_f}
     puts final_crypto
     sleep(0.05)    
    end
    puts "FIN DU LISTING".green
    puts "ACTUALISATION DANS 30s".blue
    puts "CTRL + C POUR SORTIR DU PROGRAMME".red
    sleep(30)
    end
end


def perform
    system('clear')
    puts "      DataInDeep - Scrapper by D1sh ".red
    puts " |===============================================|".blue
    puts "      [1] Recuperer les noms des cryptos ?".green
    puts " |===============================================|".blue
    puts "      [2] Recuperer les valeurs des cryptos ?".green
    puts " |===============================================|".blue
    puts "      [3] Un melange des deux ?".green
    puts " |===============================================|".blue
    puts "      [4] Un scan de la page  ?".green
    puts " |===============================================|".blue
    user_choice = gets.chomp.to_i

    if user_choice == 1
      cryto_name()
      puts @array_name
    end
    
    if user_choice == 2
      crypto_value()
      puts @array_value
    end

    if user_choice == 3
      my_final_hash_one()
      sleep (5)
      puts "On retourne au menu dans 30s".green
      sleep(30)
      system('clear')
      perform()
    end

    if user_choice == 4
      my_final_hash()
    end
  end
perform()