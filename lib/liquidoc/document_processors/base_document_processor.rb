module Liquidoc
  module DocumentProcessors
    class BaseDocumentProcessor
      extend Forwardable

      attr_reader :path

      def initialize(path)
        @path = path
      end

      def render(context = {})
        raise NotImplementedError
      end

      def clean_content
        raise NotImplementedError
      end

      def tags; []; end
      def variables; []; end
      def errors; []; end
    end
  end
end
