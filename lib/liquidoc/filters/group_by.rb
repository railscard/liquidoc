module Liquid
  module Filters
    module GroupBy
      # Group an array of items by a property
      #
      # input - the inputted Enumerable
      # property - the property
      #
      # Returns an array of Hashes, each looking something like this:
      #  {"name"  => "larry"
      #   "items" => [...] } # all the items where `property` == "larry"
      def group_by(input, property)
        if groupable?(input)
          input.group_by do |item|
            item_property(item, property).to_s
          end.inject([]) do |memo, i|
            memo << {'name' => i.first, 'items' => i.last}
          end
        else
          input
        end
      end

      private

      def groupable?(element)
        element.respond_to?(:group_by)
      end

      def item_property(item, property)
        if item.respond_to?(:to_liquid)
          item.to_liquid[property.to_s]
        else
          item[property.to_s]
        end
      end
    end

    ::Liquid::Template.register_filter(GroupBy)
  end
end
