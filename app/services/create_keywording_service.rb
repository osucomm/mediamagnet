class CreateKeywordingService

  def initialize(item, tag)
    @item = item
    @tag = tag
  end

  def execute
    if Keyword.valid_keyword?(@tag.name)
      @item.keywords << Keyword.where(name: @tag.name, 
                                      display_name: @tag.name,
                                      category_id: Category.find(@tag.name.split('-').first).id)
                          .first_or_create
    end

    @item.mappings.each do |mapping|
      if mapping.tag_id == @tag.id
        @item.keywords << mapping.keyword
      end
    end

  end

end