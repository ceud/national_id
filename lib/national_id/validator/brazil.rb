module NationalID
  class Validator
    class Brazil < Base
      class << self
        FORMAT = '###-###-###-##'

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
          first = 0
          (0..8).each do |index|
            first += id[index] * (index + 1)
          end

          (first % 11) % 10
        end

        def second_check_digit(id, first)
          second = 0
          (1..8).each do |index|
            second += id[index] * index
          end

          ((second + (first * 9)) % 11) % 10
        end
      end
    end
  end
end
