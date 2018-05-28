require 'test_helper'

describe Liquidoc::Template do
  describe '#variables' do
    it 'extracts variables' do
      template = Liquidoc::Template.new('{{var1}} {%for a in b%} {{a}} {% endfor %} {{var2}}')

      assert_equal(template.variables.length, 2)
      assert_equal(template.variables[0].raw, 'var1')
      assert_equal(template.variables[1].raw, 'var2')
    end
  end

  describe '#tags' do
    it 'extracts tags' do
      template = Liquidoc::Template.new('{{var1}}{% for foo in bar %} {{ foo.bar }} {% endfor %}')

      assert_equal(template.tags.size, 1)
      assert_kind_of(Liquid::For, template.tags.first)
    end
  end

  describe '#errors' do
    it 'extracts liquid template errors' do
      template = Liquidoc::Template.new('{{x}} {{y}}')
      template.render({})

      assert_equal(template.errors.size, 2)
      assert_equal(template.errors[0].message, 'Liquid error: undefined variable x')
      assert_equal(template.errors[1].message, 'Liquid error: undefined variable y')
    end
  end
end
