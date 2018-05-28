module Liquid
  module Filters
    module Array
      def sum(input)
        if input.kind_of?(::Array)
          input.inject(0) { |sum, el|  sum + el.to_f }
        end
      end
    end

    ::Liquid::Template.register_filter(Array)
  end
end
