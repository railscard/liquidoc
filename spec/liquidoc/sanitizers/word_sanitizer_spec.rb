require 'test_helper'

describe Liquidoc::Sanitizers::WordSanitizer do
  before do
    @sanitizer = Liquidoc::Sanitizers::WordSanitizer.new(File.read('spec/fixtures/example.xml'))
  end

  describe '#document' do
    it 'serializes xml into string template' do
      assert_kind_of(String, @sanitizer.document)
    end

    it 'removes single-tag rows' do
      refute_match(/single_tag_row/, @sanitizer.document)
    end

    it 'keeps multi-tag rows' do
      refute_match(/multi_tag_row/, @sanitizer.document)
    end
  end

  describe '#clean_content' do
    it 'does not display elements without text' do
      assert_equal 7, @sanitizer.clean_content.size
    end

    it 'respects initial order' do
      clean_content = @sanitizer.clean_content

      assert_match(/{% for client in clients %}/, clean_content[0])
      assert_match(/{{ client.name }}/, clean_content[1])
      assert_match(/{% endfor %}/, clean_content[2])
      assert_match(/{% for product in products %}/, clean_content[3])
      assert_match(/{{ product.name }}/, clean_content[4])
      assert_match(/{% endfor %}/, clean_content[5])
      assert_match(/{{ foo.bar }}/, clean_content[6])
    end
  end
end
