class EagerPagination < SimpleDelegator
  attr_reader :records, :scope
 
  def initialize(records, scope)
    super(records)
    @records = records
    @scope = scope
  end
 
  def each
    records.public_send(scope).each do |r|
      yield r
    end
  end

  def map
    records.public_send(scope).map do |r|
      yield r
    end
  end
end
