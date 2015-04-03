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
      if validator.ancestors.include? NationalID::Validator::Base
        @validator = validator
      else
        @validator = Base
      end
    end

    def validation(value = '')
      if value.is_a?(String)
        @validator.validation(value)
      else
        Validation.new(success: false, error_message: 'Validation value must be a string.')
      end
    end
  end
end
