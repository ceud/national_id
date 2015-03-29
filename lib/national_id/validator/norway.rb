module NationalID
  class Validator
    class Norway < Base
      class << self
        FORMAT = '##-##-## #####'

        def valid?(value = '')
          return false unless pre_checks_pass?(value, FORMAT)
          id = id_list(value)
          digits_match?(id)
        end

        private

        def check_digits(id)
          first_value = 
          11 - (
            (
              (id[0] * 3) + (id[1] * 7) + (id[2] * 6) + (id[3] * 1) + 
              (id[4] * 8) + (id[5] * 9) + (id[6] * 4) + (id[7] * 5) + 
              (id[8] * 2)
            ) % 11
          )

          second_value = 
          11 - (
            (
              (id[1] * 5) + (id[2] * 4) + (id[3] * 3) + (id[4] * 2) + 
              (id[5] * 7) + (id[6] * 6) + (id[7] * 5) + (id[8] * 4) + 
              (id[9] * 3) + (first_value * 2)
            ) % 11
          )

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
