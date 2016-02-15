module ApplicationHelper
  def horizontal_form
    {
      html: { class: 'form-horizontal' },
      wrapper: :horizontal_form,
      wrapper_mappings: {
        check_boxes: :horizontal_radio_and_checkboxes,
        radio_buttons: :horizontal_radio_and_checkboxes,
        file: :horizontal_file_input,
        boolean: :horizontal_boolean
      }
    }
  end

  def markdown(text)
    if text
      options = {
        filter_html: true,
        hard_wrap:   true,
        disable_indented_code_blocks: true,
      }

      extensions = {
        autolink: true,
      }

      renderer = Redcarpet::Render::HTML.new(options)
      Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
    end
  end
end
