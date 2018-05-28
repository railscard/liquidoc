require 'test_helper'

describe Liquidoc::Document do
  describe '#render_to_string' do
    it 'performs variable substitution' do
      # Prepare initial data
      template_document = Liquidoc::Document.new('spec/fixtures/example.txt')
      template_data = { 'var1' => 'Oh', 'var2' => 'my' }

      # Render document
      result = template_document.render_to_string(template_data)

      # Check variable substitution
      assert_match(/Oh my!/, result)
    end
  end

  describe '#render_to_file' do
    it 'creates file' do
      # Prepare initial data
      template_document = Liquidoc::Document.new('spec/fixtures/invoice_template.docx')
      template_data = YAML.load_file('spec/fixtures/invoice_data.yml')
      result_filename = "/tmp/document-#{rand(1000)}.docx"

      # Render document
      template_document.render_to_file(result_filename, template_data)

      # Check if document exists
      assert File.exist?(result_filename)

      # Cleanup
      File.delete(result_filename)
    end
  end
end
