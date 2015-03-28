module NationalID
  class Validator
    class Brazil
      attr_accessor :value
      attr_reader :format

      def initialize(value)
        @value = value
        @format = '###-###-###-##'
      end

      def validate
        return false if value.length != format.length

        # check that value isn't simply all zeroes
        return false if value.gsub(/[0-]/, '') == ''

        id = value.gsub(/-/, '').split('')

        # check each digit is actually numeric
        id.each do |digit|
          return false unless digit =~ /[[:digit:]]/
        end

        id = id.map {|i| i.to_i}

        first_value = ((id[0] + (id[1] * 2) + (id[2] * 3) + (id[3] * 4) + (id[4] * 5) + (id[5] * 6) + (id[6] * 7) + (id[7] * 8) + (id[8] * 9)) % 11) % 10
        second_value = ((id[1] + (id[2] * 2) + (id[3] * 3) + (id[4] * 4) + (id[5] * 5) + (id[6] * 6) + (id[7] * 7) + (id[8] * 8) + (first_value * 9)) % 11) % 10

        (first_value == id[9] && second_value == id[10])
      end
    end
  end
end
