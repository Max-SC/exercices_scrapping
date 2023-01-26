require 'open-uri'
require 'nokogiri'

# Trouver et analyser la page html
doc = Nokogiri::HTML(URI.open('https://coinmarketcap.com/all/views/all/'))

crypto_names_array = []
#  Chercher un noeud avec xpath
doc.xpath('//a[@class="cmc-table__column-name--name cmc-link"]').each do |link|
    crypto_names_array << link.content
end

crypto_values_array = []
doc.xpath('//td[5]').each do |price|
    crypto_values_array << price.content
end

crypto_array = []

(crypto_names_array.length).times do |i|
    crypto_hash = Hash.new
    crypto_hash[crypto_names_array[i]] = crypto_values_array[i]
    crypto_array << crypto_hash
end

puts crypto_array