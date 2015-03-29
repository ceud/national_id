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

          result = not_start_with_zero?(value)
          return result unless result.equal?(true)

          true
        end

        def check_digits(id)
          first_value = 
          10 - (
            (
              3 * (id[0] + id[2] + id[4] + id[6] + id[8]) + id[1] + id[3] + id[5] + id[7]
            ) % 10
          ) % 10

          second_value = 
          (
            10 - (
              (id[0] + id[2] + id[4] + id[6] + id[8] + 3) * (id[1] + id[3] + id[5] + id[7] + first_value)
            ) % 10
          ) % 10

          return first_value, second_value
        end

        def digits_match?(id)
          first, second = check_digits(id)
          result = first == id[9] && second == id[10]
          result ? Validation.new : validation_failure('NID value is invalid')
        end
      end
    end
  end
end
