require "national_id/validator/base"
require "national_id/validator/brazil"
require "national_id/validator/poland"
require "national_id/validator/turkey"

module NationalID
  class Validator
    attr_accessor :validator

    def initialize(validator = Base)
      @validator = validator
    end

    def valid?(value = '')
      @validator.valid?(value)
    end
  end
end
