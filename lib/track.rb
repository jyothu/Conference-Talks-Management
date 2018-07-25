class Track
	attr_accessor :morning_session
	attr_accessor :afternoon_session

  def initialize
    @morning_session = []
    @afternoon_session = []
  end
end
