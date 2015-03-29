module NationalID
  class Validator
    class Base
      class << self
        def valid?(value = '')
          return true
        end

        protected

        def not_zeroes?(value)
          value.gsub(/[^1-9]/, '') != ''
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

        def pre_checks_pass?(value, format)
          correct_length?(value, format) && 
          not_zeroes?(value) && 
          all_numeric?(value)
        end

        def id_list(value)
          string_id_list(value).map {|i| i.to_i}
        end

        private

        def string_id_list(value)
          value.gsub(/[^0-9]/, '').split('')
        end
      end
    end
  end
end
