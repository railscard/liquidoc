module Liquidoc
  module Sanitizers
    class BaseSanitizer
      HOOK      = /\{\%|\{[\<\:\w\s\-\>\"\'\d\=\%\|]+(\%|\})\}/
      TAG_START = /\{\%/
      TAG_END   = /\%\}/

      ONLY_ONE_TAG        = /^#{TAG_START}[^(%})]*#{TAG_END}$/
      ONLY_ONE_OPENED_TAG = /^#{TAG_START}[^(end)][^(%})]*#{TAG_END}$/
      ONLY_ONE_CLOSED_TAG = /^#{TAG_START}(end)[^(%})]*#{TAG_END}$/

      attr_reader :content

      def initialize(content)
        @content = content.force_encoding('UTF-8')
      end

      def document
        raise NotImplementedError
      end

      def clean_content
        raise NotImplementedError
      end
    end
  end
end
