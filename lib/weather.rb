require "weather/version"
require "weather/opts"
require "weather/reporter"
require "weather/presenter"

module Weather
  options = WeatherOpts.parse(ARGV)
  reporter = WeatherReporter.new(options)
  presenter = WeatherPresenter.new(reporter)

  case options.metric
  when "today"
    puts "Today's temperature at #{options.city} is between #{presenter.today_min} and #{presenter.today_max} degrees."
  when "min"
    puts "The average min temperature at #{options.city} is #{presenter.min} degrees."
  when "max"
    puts "The average max temperature at #{options.city} is #{presenter.max} degrees."
  end
end
