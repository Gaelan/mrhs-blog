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
        disable_indented_code_blocks: true
      }

      extensions = {
        autolink: true
      }

      renderer = Redcarpet::Render::HTML.new(options)
      Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
    end
  end

  # Format create/update times on posts and comments.
  def timestamp(item)
    # TODO: make datetime formats configurable.
    Time::DATE_FORMATS[:ddmmyyyy_hhmm] = '%d %B %Y %H:%M'
    Time::DATE_FORMATS[:hhmm] = '%H:%M'

    latest = item.updated_at.to_s(:ddmmyyyy_hhmm)
    original = if item.updated_at < item.created_at.end_of_day
                 item.created_at.to_s(:hhmm)
               else
                 item.created_at.to_s(:ddmmyyyy_hhmm)
    end

    if item.updated_at == item.created_at
      "<span class='timestamp-latest'>#{latest}</span>".html_safe
    else
      "<span class='timestamp-latest'>#{latest}</span> <span class='timestamp-original'>(original: #{original})</span>".html_safe
    end
  end
end
