module NationalID
  class Validator
    class Peru < Base
      class << self
        FORMAT = '##-##-##-## *'

        def validation(value = '')
          result = pre_checks_pass?(value, FORMAT)
          return result unless result.equal?(true)

          id = id_list(value)
          digits_match?(id)
        end

        private

        # last (check) character can be alphanumeric
        # first 8 should always be numeric
        def all_numeric?(value)
          list = string_id_list(value)
          list.pop(1)
          list.each do |digit|
            return validation_failure('NID value non-numeric content') unless digit =~ /[[:digit:]]/
          end
          true
        end

        def check_digit(id)
          multiplier = [3, 2, 7, 6, 5, 4, 3, 2]

          numeric_part = id.clone
          control_part = numeric_part.pop(1)

          sum = 0
          numeric_part.each_with_index do |digit, index|
            sum += digit.to_i * multiplier[index]
          end

          modulus = 11 - (sum % 11)
          key = modulus == 11 ? 0 : modulus
        end

        def digits_match?(id)
          check_list = [
            ['6', 'K'],
            ['7', 'A'],
            ['8', 'B'],
            ['9', 'C'],
            ['0', 'D'],
            ['1', 'E'],
            ['1', 'F'],
            ['2', 'G'],
            ['3', 'H'],
            ['4', 'I'],
            ['5', 'J']
          ]

          digit = check_digit(id)

          result = check_list[digit].include? id[8].to_s.upcase
          result ? Validation.new : validation_failure('NID value is invalid')
        end
      end
    end
  end
end
