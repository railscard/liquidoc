require 'test_helper'

describe Liquid::Filters::Array do
  describe '#sum' do
    it 'calculates sum of all elements in array' do
      template = Liquidoc::Template.new('{{ numbers | sum }}')
      sum = template.render({ 'numbers' => [50, 100, 120] })

      assert_equal('270.0', sum)
    end

    it 'works with map' do
      template = Liquidoc::Template.new("{{ products | map: 'price' | sum }}")
      sum = template.render({ 'products' => [
          { 'name' => 'Product 1', 'price' => 50 },
          { 'name' => 'Product 2', 'price' => 100 },
          { 'name' => 'Product 3', 'price' => 120 },
      ] })

      assert_equal('270.0', sum)
    end
  end
end
