require 'spec_helper'

describe NationalID::Validation do
  let(:success) { NationalID::Validation.new }
  let(:failure) { NationalID::Validation.new(success: false, error_message: 'foo') }

  describe '#initialize' do
    it 'defaults to successful' do
      expect(success.success?).to be true
    end
  end

  describe '#success?' do
    it 'returns true on success' do
      expect(success.success?).to be true
    end

    it 'returns false on failure' do
      expect(failure.success?).to be false
    end
  end

  describe '#errors?' do
    it 'returns true if error message is not blank' do
      expect(failure.errors?).to be true
    end

    it 'returns false if error message is blank' do
      expect(success.errors?).to be false
    end
  end

  describe '#error_message' do
    it 'returns message string' do
      expect(failure.error_message).to eq('foo')
    end
  end
end
