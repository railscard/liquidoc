module Liquidoc
  module DocumentProcessors
    class UnknownDocumentProcessor < BaseDocumentProcessor
      def_delegator :template, :errors
      def_delegator :template, :tags
      def_delegator :template, :variables
      def_delegator :template, :render

      def clean_content
        content
      end

      def template
        @template ||= Template.new(content)
      end

      private

      def content
        @content ||= File.read(path)
      end
    end
  end
end
