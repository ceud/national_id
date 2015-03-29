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

        def check_digits(id)
          first_value = 
          (
            (
              id[0] + (id[1] * 2) + (id[2] * 3) + (id[3] * 4) + (id[4] * 5) + 
              (id[5] * 6) + (id[6] * 7) + (id[7] * 8) + (id[8] * 9)
            ) % 11
          ) % 10

          second_value = 
          (
            (
              id[1] + (id[2] * 2) + (id[3] * 3) + (id[4] * 4) + (id[5] * 5) + 
              (id[6] * 6) + (id[7] * 7) + (id[8] * 8) + (first_value * 9)
            ) % 11
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
