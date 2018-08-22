require 'slop'

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
