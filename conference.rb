require './lib/scheduler'
require './lib/talk'
require './lib/track'
require 'time'
require 'byebug'

class Conference
  TALKS_INPUT_FILE_PATH = 'data/talks.txt'.freeze

  def self.call(file_name: TALKS_INPUT_FILE_PATH)
    Scheduler.new(file_name).call
  end
end


Conference.call
