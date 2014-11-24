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

end
