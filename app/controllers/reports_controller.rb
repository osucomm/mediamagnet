class ReportsController < ApplicationController
  def keyword_usage
    @keywords = Keyword.all
    @channels = if params[:channel_ids]
                  Channel.where(id: params[:channel_ids].split(','))
                else
                  Channel.all
                end
    @keyword = Keyword.find(params[:keyword_id])
    # @channel = Channel.find(params[:channel_id])
    series = @keyword.keyword_usages.
      by_channels(@channels.map(&:id)).
      group_by(&:starts_at).
      values.map do |set_of_keywords|
        set_of_keywords.map(&:count).reduce(:+)
      end
    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(:text => "Keyword Usage Over Time")
      f.xAxis(
        name: 'New Items',
        type: 'datetime',
        minRange: 14 * 24 * 3600000
      )
      f.series(
        name: 'New Items',
        pointInterval: 1.week,
        pointStart: @keyword.keyword_usages.first.starts_at,
        :data => series
      )

      f.yAxis [
        {:title => {:text => "New Items With Keyword '#{@keyword.name}'", margin: 70} , 
                    min: 0,
                    allowDecimals: false },
      ]

      f.legend(:align => 'right', :verticalAlign => 'top', :y => 75, :x => -50, :layout => 'vertical',)
      f.chart({type: 'line'})
    end
  end
end
