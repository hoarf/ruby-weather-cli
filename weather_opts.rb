# -*- coding: utf-8 -*-
require "optparse"
require "ostruct"


class WeatherOpts
  FARADAY_WEATHER_ENDPOINT = "http://api.tiempo.com/index.php?api_lang=es&division=102&affiliate_id=zdo2c683olan"
  DEFAULT_CITY = "Barcelona"
  DEFAULT_METRIC = :today

  def self.parse(args)
    OpenStruct.new.tap do |options|
      options.metric = DEFAULT_METRIC
      options.city = DEFAULT_CITY
      options.endpoint = FARADAY_WEATHER_ENDPOINT

      OptionParser.new  do |o|
        o.banner = "Usage: weather [ metric ] [ city ]"
        o.separator ""
        o.separator "Options:"

        o.on "-m","--metric[=METRIC]","Either: 'today', 'max' or 'min'. Default: 'today'." do |m|
          unless ['max', 'min', 'today'].include?(m)
            puts "Invalid metric: '#{m}'"
            exit
          end
          options.metric = m
        end

        o.on "-l","--location[=LOCATION]","The metric's location. Default: Barcelona." do |m|
          options.metric = m
        end

        o.on_tail("-h", "--help", "Show this message") do
          puts o
          exit
        end

      end.parse!(args)
    end
  end
end



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
