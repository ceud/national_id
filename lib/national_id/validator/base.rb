module NationalID
  class Validator
    class Base
      class << self
        def validation(_value = '')
          Validation.new
        end

        protected

        def pre_checks_pass?(value, format)
          return error_correct_length unless correct_length?(value, format)
          return error_not_zeroes unless not_zeroes?(value)
          true
        end

        def not_zeroes?(value)
          value.gsub(/[0]/, '') != ''
        end

        def not_start_with_zero?(value)
          value[0] != '0'
        end

        def correct_length?(value, format)
          value.length == format.length
        end

        def all_numeric?(value)
          string_id_list(value).each do |digit|
            return false unless digit =~ /[[:digit:]]/
          end
          true
        end

        def numeric?(value)
          true if Float(value) rescue false
        end

        def numeric_list(value)
          string_id_list(value).map { |i| numeric?(i) ? i.to_i : i.upcase.ord - 55 }
        end

        def id_list_to_numeric(id)
          id.map { |i| numeric?(i) ? i.to_i : i.upcase.ord - 55 }
        end

        def id_list(value)
          string_id_list(value).map { |i| numeric?(i) ? i.to_i : i }
        end

        def string_id_list(value)
          value.gsub(/[^0-9a-zA-Z]/, '').split('')
        end

        def error_not_zeroes
          validation_failure(NID_ONLY_ZEROES_MSG)
        end

        def error_not_start_with_zero
          validation_failure(NID_NO_ZERO_START_MSG)
        end

        def error_correct_length
          validation_failure(NID_WRONG_LENGTH_MSG)
        end

        def error_all_numeric
          validation_failure(NID_NON_NUMERIC_MSG)
        end

        def error_numeric
          validation_failure(NID_NON_NUMERIC_CHECK_MSG)
        end

        def validation_failure(error_message)
          Validation.new(success: false, error_message: error_message)
        end
      end
    end
  end
end
