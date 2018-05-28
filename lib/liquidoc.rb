require 'zip'
require 'liquid'
require 'nokogiri'

require 'liquidoc/sanitizers/base_sanitizer'
require 'liquidoc/sanitizers/word_sanitizer'

require 'liquidoc/document_processors/base_document_processor'
require 'liquidoc/document_processors/unknown_document_processor'
require 'liquidoc/document_processors/word_document_processor'

require 'liquidoc/template'
require 'liquidoc/document'

require 'liquidoc/filters/date'
require 'liquidoc/filters/number'
require 'liquidoc/filters/array'

require 'liquidoc/version'

module Liquidoc
  class << self
    def document(path)
      Document.new(path)
    end

    alias template document
  end
end
