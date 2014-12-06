class TagParser
  def initialize(text)
    @text = text
  end

  def parse
    @text.scan(/\#\w+/).map {|match| match.gsub('#','') } if @text
  end
end
