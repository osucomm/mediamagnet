module ApiHelper
  def meta(result)
    base_meta = {
      :links => {
        :first => nil,
        :previous => nil,
        :self => nil,
        :next => nil,
        :last => nil
      },
      :current_page => nil,
      :total_pages => nil,
      :total_results => nil,
      :status => response.code.to_i
    }

    # if this is a collection...
    if result.respond_to? :count

      base_meta.merge({
        :links => {
          :first => first_page_url,
          :previous => previous_page_url(result),
          :self => self_url,
          :next => next_page_url(result),
          :last => last_page_url(result)
        },
        :current_page => result.current_page,
        :total_pages => result.total_pages,
        :total_results => result.total_count
      })

    # Otherwise, for a single record...
    else
      base_meta.merge({
        :links => base_meta[:links].merge({
          :self => self_url
        }),
        :current_page => 1,
        :total_pages => 1,
        :total_results => 1
      })
    end

  end

  def self_url
    url_with_format()
  end

  def first_page_url
    url_with_format(:page => 1)
  end

  def previous_page_url(result)
    return nil if result.current_page <= 1
    url_with_format(:page => result.current_page-1)
  end

  def next_page_url(result)
    return nil if result.current_page >= result.total_pages
    url_with_format(:page => result.current_page+1)
  end

  def last_page_url(result)
    url_with_format(:page => result.total_pages)
  end


  private

  def url_with_format(args={})
    url_for(
      request.parameters.merge(
        args.merge(
          {only_path: false, format: request.format.to_sym})))
  end

end
