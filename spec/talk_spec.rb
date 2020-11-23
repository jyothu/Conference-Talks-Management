require 'spec_helper'

describe Talk do
  after(:each) do
    Talk.all.clear
  end

  describe '#initialize' do
    let!(:talk) { Talk.new('Test talk 30min') }

    it 'accepts talk string and initialize talk object with title and duration' do
      expect(talk.title).to eq('Test talk 30min')
      expect(talk.duration).to eq 30
    end
  end

  describe '#display_title' do
    let!(:talk) { Talk.new('Test talk 30min') }

    subject { talk.display_title }

    before do
      talk.session_time = '09:00AM'
    end

    it { is_expected.to eq('09:00AM Test talk 30min') }
  end

  # context 'when invalid inputs' do
  #   let(:talk) { Talk.new('An Invalid talk') }

  #   it 'throws an execption if the format is incorrect' do
  #     expect(talk).to raise_error('Invalid talk')
  #   end
  # end

  context 'when Lightning inputs' do
    let(:talk) { Talk.new('Rails for Python Developers lightning') }

    it 'sets duration as 5 mins' do
      expect(talk.duration).to eq(Talk::LIGHTNING_DURATION)
    end
  end

  describe '.total_minutes' do
    before do
      Talk.class_variable_set :@@total_duration, 0
    end

    let!(:talk) { Talk.new('Test talk 60min') }
    let!(:talk2) { Talk.new('Test talk 30min') }

    subject { Talk.total_minutes }

    it { is_expected.to eq(90) }
  end

  describe '.count' do
    let!(:talk) { Talk.new('Test talk 60min') }
    let!(:talk2) { Talk.new('Test talk 30min') }

    subject { Talk.count }

    it { is_expected.to eq(2) }
  end

  describe '.all' do
    let!(:talk) { Talk.new('Test talk 60min') }
    let!(:talk2) { Talk.new('Test talk 30min') }

    subject { Talk.all }

    it { is_expected.to eq([talk, talk2]) }
  end

  describe '.dsort' do
    let!(:talk) { Talk.new('Test talk 30min') }
    let!(:talk2) { Talk.new('Test talk 60min') }

    subject { Talk.dsort }

    it { is_expected.to eq([talk2, talk]) }
  end
end
