require 'spec_helper'

describe Track do
  describe '#initialize' do
    it 'initialize track object with morning_session & afternoon_session as empty array' do
      track = Track.new
      expect(track.morning_session).to eq []
      expect(track.afternoon_session).to eq []
    end
  end
end