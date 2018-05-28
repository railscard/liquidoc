module Liquidoc
  module Sanitizers
    class WordSanitizer < BaseSanitizer
      def initialize(content)
        super

        prepare_template
      end

      def document
        @document ||= @prepared_template.serialize(save_with: Nokogiri::XML::Node::SaveOptions::NO_DECLARATION)
      end

      def clean_content
        @clean_content ||= @prepared_template.xpath('//w:t').map(&:text)
      end

      private

      def prepare_template
        @prepared_template = Nokogiri::XML(content.gsub(HOOK) { |match| match.gsub(/<[^>]*>/, '') })

        remove_obsolete_table_rows(@prepared_template)
        remove_empty_paragraphs(@prepared_template)
      end

      def remove_obsolete_table_rows(xml_document)
        xml_document.xpath("//w:tr").each do |row|
          row_content = row.content.strip

          match_open  = row_content.match(ONLY_ONE_OPENED_TAG)
          match_close = row_content.match(ONLY_ONE_CLOSED_TAG)

          next if match_open && match_close

          replace_row_with_ld_node(row, match_open.string) if match_open
          replace_row_with_ld_node(row, match_close.string) if match_close
        end
      end

      def remove_empty_paragraphs(xml_document)
        xml_document.xpath('//w:p').each do |row|
          match_only_tag = row.content.strip.match(ONLY_ONE_TAG)

          replace_row_with_ld_node(row, match_only_tag.string) if match_only_tag
        end
      end

      def replace_row_with_ld_node(row, content)
        fd_node = Nokogiri::XML::Node.new('w:t', row.document)
        fd_node.content = content
        fd_node['class'] = 'liquidoc_entry'
        row.replace fd_node
      end
    end
  end
end
