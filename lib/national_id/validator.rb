require "national_id/validator/none"
require "national_id/validator/brazil"
require "national_id/validator/poland"
require "national_id/validator/turkey"

module NationalID
  class Validator
    attr_accessor :validator

    def initialize(validator)
      @validator = validator
    end

    def validate(value = '')
      @validator.validate(value)
    end
  end
end
