class Track
  attr_accessor :morning_talks, :afternoon_talks

  MORNING_TALKS_DURATION = 180
  AFTERNOON_TALKS_DURATION = 240
  SINGLE_TRACK_TOTAL_DURATION = 420.0

  @@all_tracks = []

  def initialize
    @morning_talks = []
    @afternoon_talks = []

    @@all_tracks << self
  end

  class << self
    def all
      @@all_tracks
    end

    def display_talks
      all.each_with_index do |track, index|
        p "Track #{index + 1}:"
        track.morning_talks.each { |talk| p talk.display_title }
        p '12:00 PM Lunch'
        track.afternoon_talks.each { |talk| p talk.display_title }
        p '05:00 PM Networking Event'
      end
    end
  end
end
