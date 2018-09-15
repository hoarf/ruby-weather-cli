require_relative('weather_opts')

options = WeatherOpts.parse(ARGV)
puts options
