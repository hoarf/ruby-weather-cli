# -*- coding: utf-8 -*-
require "pry"
require "faraday"
require "nokogiri"
require "optparse"
require_relative "controller"

ARGV << "-h" if ARGV.empty?

FARADAY_WEATHER_ENDPOINT = "http://api.tiempo.com/index.php?api_lang=es&division=102&affiliate_id=zdo2c683olan"

OptionParser.new  do |o|
  o.banner = "Usage: weather [options] | command city"
  o.separator ""
  o.on "-t", "--today", "Shows today's temperature for the city."
  o.on "-M", "--max", "Shows the maximum temperature for the week for the city."
  o.on "-m", "--min", "Shows the minimum temperature for the week for the city."
  o.separator ""
  o.separator "Options:"
  o.on("-h", "--help", "Show help") do
    puts o
  end
end.parse!

# index = Faraday.get(FARADAY_WEATHER_ENDPOINT)
# index_response = Nokogiri::XML(index.body)

# city_uri = index_response.at('data:contains("Tona")').css("url").text

# city = Faraday.get("#{city_uri}&affiliate_id=zdo2c683olan")
# city_response = Nokogiri::XML(city.body)

# puts city_response
# mins = city_response
#   .css('var:contains("Temperatura Mínima")')
#   .css("data")
#   .css("forecast")
#   .collect(&:values)
#   .map(&:last)

# maxs = city_response
#   .css('var:contains("Temperatura Máxima")')
#   .css("data")
#   .css("forecast")
#   .collect(&:values)
#   .map(&:last)

# puts mins.first, maxs.first if args[:today]
