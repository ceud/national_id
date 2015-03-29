module NationalID
  class Validator
    class Turkey < Base
      class << self
        FORMAT = '###-###-###-##'

        def valid?(value = '')
          return false unless pre_checks_pass?(value, FORMAT)
          id = id_list(value)
          digits_match?(id)
        end

        private

        def pre_checks_pass?(value, format)
          super && not_start_with_zero?(value)
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
          first == id[9] && second == id[10]
        end
      end
    end
  end
end
