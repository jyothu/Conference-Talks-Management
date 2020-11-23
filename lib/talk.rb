class Talk
  attr_accessor :session_time, :title, :duration

  LIGHTNING_DURATION = 5

  @@all_talks = []
  @@total_duration = 0

  def initialize(title)
    @title = title
    @duration = calculate_duration

    @@all_talks << self
    @@total_duration += duration
  end

  def display_title
    "#{session_time} #{title}"
  end

  class << self
    def count
      @@all_talks.size
    end

    def all
      @@all_talks
    end

    def dsort
      @@all_talks.sort_by(&:duration).reverse!
    end

    def total_minutes
      @@total_duration
    end
  end

  private

  def calculate_duration
    minutes = title.match(/\d+/).to_s.to_i
    return minutes unless minutes.zero?

    raise 'Invalid talk' unless title.match?('lightning')

    LIGHTNING_DURATION
  end
end
