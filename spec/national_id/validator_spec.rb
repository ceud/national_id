require 'spec_helper'

describe NationalID::Validator do
  describe '#initialize' do
    it 'defaults to Base validator' do
      subject = NationalID::Validator.new
      expect(subject.validator).to eq(NationalID::Validator::Base)
    end

    it 'can instantiate with custom validator' do
      subject = NationalID::Validator.new(NationalID::Validator::Brazil)
      expect(subject.validator).to eq(NationalID::Validator::Brazil)
    end
  end

  describe '#validation' do
    it 'calls validation method specific to chosen validator' do
      subject = NationalID::Validator.new
      expect(subject.validation).to be_a NationalID::Validation
    end
  end
end
