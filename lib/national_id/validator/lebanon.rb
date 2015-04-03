module NationalID
  class Validator
    class Lebanon < Base
      class << self
        FORMAT = '**** **** **** #'

        def validation(value = '')
          result = pre_checks_pass?(value, FORMAT)
          return result unless result.equal?(true)

          id = id_list(value)
          digits_match?(id)
        end

        private

        def pre_checks_pass?(value, format)
          result = correct_length?(value, format)
          return result unless result.equal?(true)

          result = not_zeroes?(value)
          return result unless result.equal?(true)

          result = numeric?(value.slice(-1))
          return validation_failure('NID contains non-numeric check digit') unless result.equal?(true)

          true
        end

        def check_digit(id)
          weighted(id_list_to_numeric(id)).reduce(0, :+) % 10
        end

        def digits_match?(id)
          result = check_digit(id) == id[12]
          result ? Validation.new : validation_failure('NID value is invalid')
        end

        def weighted(numeric_id)
          weights = [7, 3, 1]
          numeric_id.each_with_index do |digit, index|
            numeric_id[index] *= weights[index % 3]
          end
        end
      end
    end
  end
end
