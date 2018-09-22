require "weather/version"
require "weather/opts"
require "weather/request"
require "weather/response"
require "weather/presenter"

module Weather
  module CLI
    def self.start
      options = Weather::Opts.parse(ARGV)

      index_request = XMLRequest.new(options.endpoint)
      index = IndexXMLResponse.new(index_request.get)

      city_endpoint = index.city_url(options.city)
      city_request = XMLRequest.new(city_endpoint)

      city = CityXMLResponse.new(city_request.get)
      presenter = Weather::Presenter.new(city)

      case options.metric
      when "today"
        puts "Today's temperature at #{options.city} is between #{presenter.today_min} and #{presenter.today_max} degrees."
      when "min"
        puts "The average min temperature at #{options.city} is #{presenter.min} degrees."
      when "max"
        puts "The average max temperature at #{options.city} is #{presenter.max} degrees."
      end
    end
  end
end
