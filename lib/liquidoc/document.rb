require 'mimemagic'
require 'mimemagic/overlay'

module Liquidoc
  class Document
    extend Forwardable

    DEFAULT_PROCESSOR = DocumentProcessors::UnknownDocumentProcessor
    PROCESSORS_MAP = {
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document' =>
          DocumentProcessors::WordDocumentProcessor
    }

    def_delegator :document_processor, :errors
    def_delegator :document_processor, :tags
    def_delegator :document_processor, :variables
    def_delegator :document_processor, :clean_content
    def_delegator :document_processor, :render

    def initialize(path)
      @path = path
    end

    def render_to_string(context = {})
      render(context)
    end

    def render_to_file(filename, context = {})
      File.open(filename, 'wb') do |f|
        f.write render_to_string(context)
      end
    end

    private

    def document_mime_type
      @mime ||= MimeMagic.by_path(@path)
    end

    def document_processor
      @processor ||= PROCESSORS_MAP.fetch(document_mime_type.type, DEFAULT_PROCESSOR).new(@path)
    end
  end
end
