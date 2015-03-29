module NationalID
  class Validator
    class Poland < Base
      class << self
        FORMAT = '##-##-## #####'

        def valid?(value = '')
          return false unless pre_checks_pass?(value, FORMAT)
          id = id_list(value)
          digits_match?(id)
        end

        private

        def check_digit(id)
          check_mod =
          (
            id[0] + (id[1] * 3) + (id[2] * 7) + (id[3] * 9) +
            id[4] + (id[5] * 3) + (id[6] * 7) + (id[7] * 9) +
            id[8] + (id[9] * 3)
          ) % 10

          check_mod == 0 ? 0 : 10 - check_mod
        end

        def digits_match?(id)
          check_digit(id) == id[10]
        end
      end
    end
  end
end
