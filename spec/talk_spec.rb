require 'spec_helper'

describe Talk do
  describe '#initialize' do
    it 'initialize talk object with description and length from the given talk string' do
      talk = Talk.new('Test talk 30min')
      expect(talk.description).to eq 'Test talk 30min'
      expect(talk.length).to eq 30
    end

    it 'initialize talk object with legnth 5 if talk string includes the word lightning' do
      talk = Talk.new('Test talk lightning')
      expect(talk.description).to eq 'Test talk lightning'
      expect(talk.length).to eq 5
    end

    it 'throws an execption if the format is incorrect' do
      expect { Talk.new('this is a failing talk') }
        .to raise_error 'incorrect format'
    end
  end
end
