module NationalID
  class Validator
    class Base
      class << self
        def validation(value = '')
          return Validation.new
        end

        protected

        def not_zeroes?(value)
          result = value.gsub(/[^1-9]/, '') != ''
          result ? result : validation_failure('NID value cannot contain only zeroes')
        end

        def not_start_with_zero?(value)
          result = value[0] != '0'
          result ? result : validation_failure('NID value cannot start with zero')
        end

        def correct_length?(value, format)
          result = value.length == format.length
          result ? result : validation_failure('NID value has wrong length')
        end

        def all_numeric?(value)
          p 'base all_numeric?'
          string_id_list(value).each do |digit|
            return validation_failure('NID value non-numeric content') unless digit =~ /[[:digit:]]/
          end
          true
        end

        def pre_checks_pass?(value, format)
          result = correct_length?(value, format)
          return result unless result.equal?(true)

          result = not_zeroes?(value)
          return result unless result.equal?(true)

          result = all_numeric?(value)
          return result unless result.equal?(true)

          true
        end

        def id_list(value)
          string_id_list(value).map {|i| numeric?(i) ? i.to_i : i}
        end

        def string_id_list(value)
          value.gsub(/[^0-9a-zA-Z]/, '').split('')
        end

        def validation_failure(error_message)
          Validation.new(success: false, error_message: error_message)
        end

        def numeric?(value)
          true if Float(value) rescue false
        end
      end
    end
  end
end
