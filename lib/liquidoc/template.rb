module Liquidoc
  class Template
    def initialize(content)
      @template = Liquid::Template.parse(content, error_mode: :warn)
    end

    def render(context)
      @template.render(context, { strict_variables: true, strict_filters: true })
    end

    def variables
      @template.root.nodelist.select { |node| node.class <= Liquid::Variable }
    end

    def tags
      @template.root.nodelist.select { |node| node.class <= Liquid::Tag }
    end

    def errors
      @template.errors
    end
  end
end
