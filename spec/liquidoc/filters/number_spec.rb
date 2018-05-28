require 'test_helper'

describe Liquid::Filters::Number do
  describe '#fix' do
    it 'returns fixed part of decimal' do
      template = Liquidoc::Template.new('{{ number | fix }}')
      result = template.render({ 'number' => 10.55 })

      assert_equal('10', result)
    end
  end

  describe '#frac' do
    it 'returns fraction' do
      template = Liquidoc::Template.new('{{ number | frac }}')
      result = template.render({ 'number' => 10.55 })

      assert_equal('55', result)
    end
  end
end
