class YoutubeChannel < Channel
  def service_id_name
    'Channel name'
  end

  def icon
    'youtube-play'
  end

  def client
    @client ||= YouTubeIt::Client.new(:dev_key => ENV['YOUTUBE_API_KEY'])
  end

end
