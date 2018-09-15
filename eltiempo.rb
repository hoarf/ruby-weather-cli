require_relative('opts')
require_relative('reporter')
require_relative('presenter')

options = WeatherOpts.parse(ARGV)
reporter = WeatherReporter.new(options)
presenter = WeatherPresenter.new(reporter)

case options.metric
when "today"
  puts "Today's temperature at #{options.city} is between #{presenter.today_min} and #{presenter.today_max} degrees."
when "min"
  puts "The average min temperature at #{options.city} is #{presenter.min} degres."
when "max"
  puts "The average max temperature at #{options.city} is #{presenter.max} degrees."
end
