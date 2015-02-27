class ExchangeTimeParser
  def initialize(datetimestring)
    @date = datetimestring
  end

  def parse
    Time.parse(@date.to_s[0..15])
  end
end
