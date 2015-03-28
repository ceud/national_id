module NationalID
  class Validator
    class Turkey
      attr_accessor :value
      attr_reader :format

      def initialize(value)
        @value = value
        @format = '###-###-###-##'
      end

      def validate
        return false if value.length != format.length

        # check that first digit is not zero
        return false if value[0] == '0'

        # check that value isn't simply all zeroes
        return false if value.gsub(/[0-]/, '') == ''

        id = value.gsub(/-/, '').split('')

        # check each digit is actually numeric
        id.each do |digit|
          return false unless digit =~ /[[:digit:]]/
        end

        id = id.map {|i| i.to_i}

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

        (first_value == id[9] && second_value == id[10])
      end
    end
  end
end
