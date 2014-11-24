class HelpController < ApplicationController
  before_filter :force_trailing_slash, only: [:index, :category]

  def index
    @file_name = Rails.root.join('doc', 'README.md')
    @subtitle = 'content service'
    render_page 'show'
  end

  def category
    @file_name = Rails.root.join('doc', params[:category], 'README.md')
    render_page
  end

  def show
    @file_name = Rails.root.join('doc', params[:category], params[:file] + '.md')
    render_page
  end


  private

    def force_trailing_slash
      redirect_to request.original_url + '/' unless request.original_url.match(/\/$/)
    end

    def render_page(view='show')
      renderer = Redcarpet::Render::HTML.new()
      markdown = Redcarpet::Markdown.new(renderer)

      if File.exists?(@file_name)
        @html = Nokogiri::HTML::fragment( markdown.render( File.read(@file_name) ).gsub(/\.md"/, '"') )
        title_node = @html.at_css('h1')
        @title = title_node.try(:text)
        title_node.try(:remove)
        render view
      else
        not_found!
      end
    end

end