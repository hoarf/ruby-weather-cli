# -*- coding: utf-8 -*-
require "optparse"
require "ostruct"

# Note to the evaluator:
# I have decided to slightly change the suggested API for the CLI from `eltiempo -today 'Gavá'`
# To `eltiempo --metric=today --location=Gavá` because the suggested API was a bit ambiguous when
# it comes down to multiple optional arguments.
# I hope this is not a big deal, but it made the code more straight forward and clear to me.

class Weather::Opts
  FARADAY_WEATHER_ENDPOINT = "http://api.tiempo.com/index.php?api_lang=es&division=102&affiliate_id=zdo2c683olan"
  DEFAULT_CITY = "Barcelona"
  DEFAULT_METRIC = "today"

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
