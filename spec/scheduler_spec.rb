require 'spec_helper'
require_relative '../conference'

describe Scheduler do
  let(:file_name_with_valid_data) { Conference::TALKS_INPUT_FILE_PATH }

  subject { described_class.new(file_name_with_valid_data) }

  describe '#call' do
    it 'processes and schedule talks in to tracks' do
      expect(subject).to receive(:process_input_talks)
      expect(subject).to receive(:initialize_tracks)
      expect(subject).to receive(:schedule_talks)
      expect(subject).to receive(:display_scheduled_talks)

      subject.call
    end

    it 'processes all talks and creates Talk object' do
      expect(Talk.count).to eq(19)
    end

    it 'initializes tracks and should have 2 tracks' do
      expect(Track.all.size).to eq(2)
    end

    it 'schedule talks and returns array of tracks from the given list of talks in which' do
      Track.all.each do |track|
        expect(track.morning_talks.map(&:duration).sum).to be <= 180
        expect(track.afternoon_talks.map(&:duration).sum).to be <= 240
      end
    end

    it 'matches the total tracks duration with the sum of input talks duration' do
      sum =
        Track.all.map do |track|
          track.morning_talks.map(&:duration).sum + track.afternoon_talks.map(&:duration).sum
        end.sum

      expect(sum).to eq(Talk.total_minutes)
    end
  end
end
