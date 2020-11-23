class Scheduler
  attr_reader :file_name

  MORNING_TALKS = 'morning_talks'.freeze
  AFTERNOON_TALKS = 'afternoon_talks'.freeze

  def initialize(file_name)
    @file_name = file_name
  end

  def call
    process_input_talks
    initialize_tracks
    schedule_talks
    display_scheduled_talks
  end

  private

  def process_input_talks
    File.readlines("#{Dir.pwd}/#{file_name}").each do |line|
      Talk.new(line.strip)
    end
  end

  def initialize_tracks
    number_of_tracks.times { track = Track.new }
  end

  # Sort talks in descending order by duraion
  # Find number of tracks needed, since we know the total duraion exactly
  # And intialize tracks
  # As per the Best fit algorithm, Fill each tracks by looping through sorted talks
  # Do this till available talks become empty
  def schedule_talks
    until available_talks.empty?
      Track.all.each do |track|
        [MORNING_TALKS, AFTERNOON_TALKS].each do |session_type|
          scheduled_talks = track.send(session_type)
          scheduled_talks_total_duration = scheduled_talks.map(&:duration).sum

          assign_talks_to_track(track, scheduled_talks, scheduled_talks_total_duration, session_type)
        end

        # When a track didn't fill exactly
        # Removing already scheduled last element from track and
        # Again trying for a exact match on available talks
        # TODO: Not a perfect solution, But, It produces better result
        # Kind of backtracking
        [MORNING_TALKS, AFTERNOON_TALKS].each do |session_type|
          session_duration = session_duration(session_type)
          scheduled_talks = track.send(session_type)
          scheduled_talks_total_duration = scheduled_talks.map(&:duration).sum

          if scheduled_talks_total_duration < session_duration
            last_unfit_talk_of_track = scheduled_talks.pop
            available_talks.push(last_unfit_talk_of_track)
            scheduled_talks_total_duration -= last_unfit_talk_of_track.duration

            assign_talks_to_track(track, scheduled_talks, scheduled_talks_total_duration, session_type)
          end
        end
      end
    end
  end

  def display_scheduled_talks
    Track.display_talks
  end

  def number_of_tracks
    (Talk.total_minutes / Track::SINGLE_TRACK_TOTAL_DURATION).ceil
  end

  def available_talks
    @available_talks ||= Talk.dsort
  end

  def session_duration(session_type)
    Object.const_get("Track::#{session_type.upcase}_DURATION", Track)
  end

  def assign_talks_to_track(track, scheduled_talks, scheduled_talks_total_duration, session_type)
    session_duration = session_duration(session_type)

    available_talks.each do |talk|
      scheduled_talks_total_duration += talk.duration

      if scheduled_talks_total_duration <= session_duration
        scheduled_talks << available_talks.delete(talk)
        talk.session_time = talk_session_time(scheduled_talks, talk, session_type)
      else
        scheduled_talks_total_duration -= talk.duration
        next
      end
    end

    track.send(session_type) == scheduled_talks
  end

  def talk_session_time(scheduled_talks, talk, session_type)
    index_value = scheduled_talks.index(talk)

    if index_value.zero?
      session_type == MORNING_TALKS ? morning_session_start_time : afternoon_session_start_time
    else
      previous_talk = scheduled_talks[index_value - 1]
      (Time.parse(previous_talk.session_time) + (previous_talk.duration * 60)).strftime('%I:%M %p')
    end
  end

  def morning_session_start_time
    Time.parse('9 AM').strftime('%I:%M %p')
  end

  def afternoon_session_start_time
    Time.parse('1 PM').strftime('%I:%M %p')
  end
end