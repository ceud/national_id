module NationalID
  class Validator
    class Norway < Base
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

        def digits_match?(id)
          first, second = check_digits(id)
          result = first == id[9] && second == id[10]
          result ? Validation.new : validation_failure(NID_INVALID_MSG)
        end

        def check_digits(id)
          first = first_check_digit(id)
          return first, second_check_digit(id, first)
        end

        def first_check_digit(id)
          multiplier = [3, 7, 6, 1, 8, 9, 4, 5, 2]

          digit = 0
          (0..8).each do |index|
            digit += id[index] * multiplier[index]
          end

          (11 - digit % 11)
        end

        def second_check_digit(id, first)
          multiplier = [5, 4, 3, 2, 7, 6, 5, 4, 3]

          digit = 0
          (0..8).each do |index|
            digit += id[index + 1] * multiplier[index]
          end

          (11 - (digit + (first * 2))) % 11
        end
      end
    end
  end
end
