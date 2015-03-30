module NationalID
  # class Validator
    class Validation
      attr_writer :success, :error_message

      def initialize(options = {})
        @success       = options[:success].nil? ? true : options[:success]
        @error_message = options[:error_message].nil? ? '' : options[:error_message]
      end

      def success?
        @success
      end

      def error_message
        @error_message ||= ''
      end

      def errors?
        !@error_message. == ''
      end
    end
  # end
end