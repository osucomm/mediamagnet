module HelpHelper
  def help_category_active?(category)
    is_active? [help_category_path(category), help_page_path(category, 'README')]
  end

  def help_page_active?(category, page)
    is_active? help_page_path(category, page)
  end  
end
