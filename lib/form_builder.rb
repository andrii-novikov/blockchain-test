module ActionView
  module Helpers
    module Tags # :nodoc:
      class TextField < Base # :nodoc:
        alias_method :old_render, :render

        def render(*args)
          errors = @object.errors[@method_name].map { |e| "#{@method_name.humanize} #{e}" }
          @options[:class] = [@options[:class], 'is-invalid'].join(' ') if errors.any?
          old_render(*args) +
          content_tag(:div, errors.first, class: 'invalid-feedback').html_safe
        end
      end
    end
  end
end
