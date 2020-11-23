require 'spec_helper'

describe Track do
  after(:each) do
    Track.all.clear
  end

  describe '#initialize' do
    let(:track) { Track.new }

    it 'initialize track object with morning_talks & afternoon_talks as empty array' do
      expect(track.morning_talks).to eq([])
      expect(track.afternoon_talks).to eq([])
    end
  end

  describe '.all' do
    let(:track) { Track.new }

    subject { Track.all }

    it { is_expected.to eq([track]) }
  end
end
