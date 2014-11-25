module ApplicationHelper

  def flash_class level
    case level
      when 'notice' then 'alert-info'
      when 'success' then 'alert-success'
      when 'error' then 'alert-danger'
      when 'alert' then 'alert-warning'
    end
  end

  def comma_list_links(objects)
    objects.map do |object|
      link_to object.name, object
    end.join(', ').html_safe
  end

  def time_or_dash(time, format = :rfc822)
    time.nil? ? '-' : time.to_formatted_s(:rfc822)
  end

  def new_mapping
    Mapping.new
  end

  def is_active?(paths)
    output_class = ''

    Array(paths).each do |path|
       output_class = 'active' if current_page?(path)
    end

    output_class
  end

  def help_icon_for(klass)
    fa_icon('question-circle',
            data: { toggle: 'tooltip', placement: 'bottom'},
            title: klass.constantize.help_text)
  end

  def help_icon(text)
    fa_icon('question-circle',
            data: { toggle: 'tooltip', placement: 'bottom'},
            title: text)
  end

  def bootstrap_label(text, type='primary')
    content_tag(:span, text, class: "label label-#{type}")
  end

  def current_user_has_entities?
    current_user && current_user.entities.any?
  end

  def current_user_is_admin?
    current_user && current_user.is_admin?
  end

  def link_to_delete(text, record, classes='')
    link_to text, record, class: classes, method: :delete,
      data: { 
        confirm: 'Are you sure?',
        confirm_message: "You are about to delete #{record.name}. This action cannot be undone.",
        confirm_ok: 'Delete'
      }
  end

end
