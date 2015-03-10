module ApiHelper
  def meta(result)
    base_meta = {
      :links => {
        :first_page => nil,
        :previous_page => nil,
        :self => nil,
        :next => nil,
        :last => nil
      },
      :current_page => nil,
      :total_pages => nil,
      :total_results => nil,
      :response_code => response.code.to_i
    }

    # if this is a collection...
    if result.respond_to? :count
      current_page_num = result.current_page
      last_page_num = result.total_pages

      base_meta.merge({
        :links => {
          :first_page => first_page,
          :previous_page => previous_page(current_page_num),
          :self => current_page(current_page_num),
          :next => next_page(current_page_num, last_page_num),
          :last => last_page(last_page_num)
        },
        :current_page => current_page_num,
        :total_pages => result.total_pages,
        :total_results => result.total_count
      })

    # Otherwise, for a single record...
    else
      base_meta.merge({
        :links => base_meta[:links].merge({
          :self => url_with_format()
        }),
        :current_page => 1,
        :total_pages => 1,
        :total_results => 1
      })
    end

  end


  private

  def first_page
    url_with_format()
  end

  def previous_page(current_page_num)
    return nil if current_page_num <= 1
    url_with_format()
  end

  def current_page(current_page_num)
    url_with_format(:page => current_page_num)
  end

  def next_page(current_page_num, last_page_num)
    return nil if current_page_num >= last_page_num
    url_with_format(:page => current_page_num+1)
  end

  def last_page(last_page_num)
    url_with_format(:page => last_page_num)
  end

  def url_with_format(args={})
    url_for(args.merge({only_path: false, format: request.format.to_sym}))
  end
end
