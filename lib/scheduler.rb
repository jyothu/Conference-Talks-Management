class Scheduler
  SESSION_LENGTHS = [180, 240]

  def schedule(talks)
    tracks = []
    scheduled_talks = []
    until talks.empty?
      track = Track.new
      SESSION_LENGTHS.each do |length|
        scheduled_talks = []
        until scheduled_talks.map(&:length).inject(:+).to_i == length
          if talks.map(&:length).inject(:+) <= length
            scheduled_talks += talks
            talks.clear
            break
          end
          talks += scheduled_talks
          scheduled_talks.clear
          talks, scheduled_talks = schedule_talks(talks, length)
        end
        length == 180 ? (track.morning_session = scheduled_talks) : (track.afternoon_session = scheduled_talks)
      end
      tracks << track
    end
    tracks
  end

  def schedule_talks(talks, length)
    scheduled_talks = [] 
    talks.each do |talk|
      if(scheduled_talks.map(&:length).inject(:+).to_i + talk.length) <= length
        scheduled_talks << talks.delete(talk)
        last_added = talk
        break if scheduled_talks.map(&:length).inject(:+).to_i == length
      end
    end
    [talks, scheduled_talks]
  end

end