module NationalID
  class Validator
    class Poland < Base
      class << self
        FORMAT = '##-##-## #####'

        def validation(value = '')
          result = pre_checks_pass?(value, FORMAT)
          return result unless result.equal?(true)

          id = id_list(value)
          digits_match?(id)
        end

        private

        def pre_checks_pass?(value, format)
          result = super
          return result unless result.equal?(true)
          return error_all_numeric unless all_numeric?(value)
          true
        end

        def check_digit(id)
          multiplier = [1, 3, 7, 9, 1, 3, 7, 9, 1, 3]

          digit = 0
          (0..9).each do |index|
            digit += id[index] * multiplier[index]
          end

          digit % 10 == 0 ? 0 : 10 - (digit % 10)
        end

        def digits_match?(id)
          result = check_digit(id) == id[10]
          result ? Validation.new : validation_failure(NID_INVALID_MSG)
        end
      end
    end
  end
end
