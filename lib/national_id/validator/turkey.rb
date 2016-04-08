module NationalID
  class Validator
    class Turkey < Base
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
          return error_not_start_with_zero unless not_start_with_zero?(value)
          true
        end

        def check_digits(id)
          first = first_check_digit(id)
          return first, second_check_digit(id, first)
        end

        def first_check_digit(id)
          p id.inspect
          sum1 = 0
          sum2 = 0

          (0..8).each do |index|
            sum1 += id[index] if index.even?
            sum2 += id[index] if index.odd?
          end

          (10 - ((3 * sum1 + sum2) % 10)) % 10
        end

        def second_check_digit(id, first)
          sum1 = 0
          sum2 = 0

          (0..8).each do |index|
            sum1 += id[index] if index.even?
            sum2 += id[index] if index.odd?
          end

          (10 - (((sum1 + 3) * (sum2 + first)) % 10)) % 10
        end

        def digits_match?(id)
          first, second = check_digits(id)
          result = first == id[9] && second == id[10]
          result ? Validation.new : validation_failure(NID_INVALID_MSG)
        end
      end
    end
  end
end
