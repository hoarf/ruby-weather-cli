require "weather/version"
require "weather/opts"
require "weather/reporter"
require "weather/presenter"

module Weather
  module CLI

    def self.start
      options = Weather::Opts.parse(ARGV)
      reporter = Weather::Reporter.new(options)
      presenter = Weather::Presenter.new(reporter)

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
