class CreateKeywordingService

  def initialize(item, tag)
    @item = item
    @tag = tag
  end

  def execute
    if Keyword.valid_keyword?(@tag.name)
      keyword = Keyword.where(name: @tag.name).first
      if category = Category.find_by_name(@tag.name.split('-'))
        keyword.category = category
      end
      @item.keywords << keyword
    end

    @item.mappings.each do |mapping|
      if mapping.tag_id == @tag.id
        @item.keywords << mapping.keyword
      end
    end

  end

end
