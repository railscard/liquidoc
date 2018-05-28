module Liquid
  module Filters
    module Number
      # WIP
      def number_to_words(input, locale = nil)
        return '' if input.blank?

        input = input.to_i
        locale ||= I18n.locale

        I18n.with_locale(locale.to_sym) { input.to_words }
      end

      def fix(input)
        input.to_i
      end

      def frac(input)
        input.to_s.split('.').last.to_i
      end
    end

    ::Liquid::Template.register_filter(Number)
  end
end
