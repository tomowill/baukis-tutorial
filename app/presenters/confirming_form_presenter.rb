class ConfirmingFormPresenter
  include HtmlBuilder

  attr_reader :form_builder, :view_context
  delegate :label, :hidden_field, :object, to: :form_builder

  def initialize(form_builder, view_context)
    @form_builder = form_builder
    @view_context = view_context
  end

  def text_field_block(name, label_text, options = {})
    markup(:div) do |m|
      m << decorated_label(name, label_text, options)
      if options[:disabled]
        m.div(object.send(name), class: 'field-value readonly')
      else
        m.div(object.send(name), class: 'field-value')
        m << hidden_field(name, options)
      end
    end
  end

  def drop_down_list_block(name, label_text, choices, options = {})
    markup(:div, class: 'input-block') do |m|
      m << decorated_label(name, label_text, options)
      m << hidden_field(name, options)
    end
  end

  def decorated_label(name, label_text, options = {})
    label(name, label_text)
  end
end
