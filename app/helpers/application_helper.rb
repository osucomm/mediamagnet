module ApplicationHelper

  def flash_class level
    case level
      when :notice then 'alert-info'
      when :success then 'alert-success'
      when :error then 'alert-danger'
      when :alert then 'alert-warning'
      when :welcome then 'alert-info'
    end
  end

  def title(page_title)
    content_for(:title) { page_title + ' - ' }
    page_title
  end

  def comma_list_links(objects)
    objects.map do |object|
      link_to object.name, object
    end.join(', ').html_safe
  end

  def time_or_dash(time, format = :rfc822)
    time.nil? ? '-' : time.time.to_formatted_s(format)
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
            title: klass.constantize.help_text, class: 'help-icon')
  end

  def help_icon(text)
    fa_icon('question-circle',
            data: { toggle: 'tooltip', placement: 'bottom'},
            title: text, class: 'help-icon')
  end

  def bootstrap_label(text, type='primary')
    content_tag(:span, text, class: "label label-#{type}")
  end

  def bootstrap_label_with_tooltip(text, options={type: 'primary'})
    content_tag(:span, 
      content_tag(:span, text, 
                  data: { toggle: 'tooltip', placement: 'bottom'},
                  title: options[:title], id: options[:id]), 
      class: "label label-#{options[:type]}")
  end

  def add_button(link, options={}) 
    link_to (fa_icon('plus', data: {toggle: 'tooltip', placement: 'top'}, title: 'Add')
            ), link, options.merge({class: 'btn btn-success btn-xs action-button'})
  end

  def edit_button(link, options={}) 
    link_to (fa_icon('pencil', data: {toggle: 'tooltip', placement: 'top'}, title: 'Edit')
            ), link, options.merge({class: 'btn btn-primary btn-xs action-button'})
  end

  def current_user_has_entities?
    current_user && current_user.entities.any?
  end

  def current_user_is_admin?
    current_user && current_user.is_admin?
  end

  def link_to_delete(text, record, classes='', remote = false)
    link_to text, record, class: classes, method: :delete, remote: remote,
      data: { 
        confirm: 'Are you sure?',
        confirm_message: "You are about to delete '#{record.to_s}'. This action cannot be undone.",
        confirm_ok: 'Delete'
      }
  end

  def link_to_confirm(text, title, message, url, classes='')
    link_to text, url, class: classes,
      data: { 
        confirm: title,
        confirm_message: message,
        confirm_ok: 'Ok'
      }
  end

end
