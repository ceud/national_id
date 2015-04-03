require 'national_id/validation'

require 'national_id/validator/base'
require 'national_id/validator/brazil'
require 'national_id/validator/lebanon'
require 'national_id/validator/norway'
require 'national_id/validator/peru'
require 'national_id/validator/poland'
require 'national_id/validator/turkey'

module NationalID
  class Validator
    attr_accessor :validator

    def initialize(validator = Base)
      @validator = validator
    end

    def validation(value = '')
      @validator.validation(value)
    end
  end
end
