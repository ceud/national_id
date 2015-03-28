module NationalID
  class Validator
    class Poland
      FORMAT = '##-##-## #####'

      def self.validate(value = '')
        return false if value.length != FORMAT.length

        # check that value isn't simply all zeroes
        return false if value.gsub(/[ 0-]/, '') == ''

        id = value.gsub(/[ ]|[-]/, '').split('')

        # check each digit is actually numeric
        id.each do |digit|
          return false unless digit =~ /[[:digit:]]/
        end

        id = id.map {|i| i.to_i}

        check_mod =
        (
          id[0] + (id[1] * 3) + (id[2] * 7) + (id[3] * 9) +
          id[4] + (id[5] * 3) + (id[6] * 7) + (id[7] * 9) +
          id[8] + (id[9] * 3)
        ) % 10

        check_value = check_mod == 0 ? 0 : 10 - check_mod

        check_value == id[10]
      end
    end
  end
end
