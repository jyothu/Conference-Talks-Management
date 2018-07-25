require './lib/scheduler'
require './lib/talk'
require './lib/track'
require 'date'

list = []
File.readlines("#{Dir.pwd}/data/talks.txt").each{|line| list << Talk.new(line.gsub(/\n/, ''))}

scheduler = Scheduler.new
tracks = scheduler.schedule(list)
tracks.each_with_index do |track, res_index|
  puts "Track #{res_index+1}"
  time = DateTime.new(2015, 04, 14, 9, 0, 0, -1)
  track.morning_session.each do |talk|
    puts "#{time.strftime('%I:%M %p')} #{talk.description}"
    time += Rational(talk.length, 1440)
  end
  puts "12:00 PM Lunch"
  time = DateTime.new(2015, 04, 14, 13, 0, 0, -1)
  track.afternoon_session.each do |talk|
    puts "#{time.strftime('%I:%M %p')} #{talk.description}"
    time += Rational(talk.length, 1440)
  end
  puts "05:00 PM Networking Event"
  puts "-----------------------------------------------------"
end