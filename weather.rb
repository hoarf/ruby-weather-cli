# -*- coding: utf-8 -*-
require 'slop'
require 'pry'
require 'faraday'
require 'nokogiri'

ARGV << '-h' if ARGV.empty?

opts = Slop.parse do |o|
  o.banner = "Usage: weather [options] | command city"
  o.separator ''
  o.separator 'commands:'
  o.string '-today' , 'Shows the todays temperature for the city.'
  o.string '-av_max', 'Shows the minimum temperature for the week for the city.'
  o.string '-av_min', 'Shows the maximum temperature for the week for the city.'
  o.separator ''
  o.separator 'options:'
  o.on('-h', '--help') do
    puts o
  end
end

index = Faraday.get('http://api.tiempo.com/index.php?api_lang=es&division=102&affiliate_id=zdo2c683olan')
index_response = Nokogiri::XML(index.body)

city_uri = index_response.at('data:contains("Tona")').css('url').text

city = Faraday.get("#{city_uri}&affiliate_id=zdo2c683olan")
city_response = Nokogiri::XML(city.body)


mins = city_response.css('var:contains("Temperatura Mínima")').css('data').css('forecast').collect(&:values).map(&:last)
maxs = city_response.css('var:contains("Temperatura Máxima")').css('data').css('forecast').collect(&:values).map(&:last)

puts maxs
puts mins
