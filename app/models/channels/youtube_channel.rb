require 'google/api_client'
require 'google/api_client/auth/installed_app'

class YoutubeChannel < Channel
  def service_id_name
    'Channel name'
  end

  def icon
    'youtube-play'
  end

  def videos
    request = {
      api_method: youtube.search.list,
      authorization: nil,
      :parameters => {part: 'snippet', channelId: service_identifier}
    }

    youtube_videos = []
    loop do
      result = client.execute(request)

      youtube_videos.concat(result.data.items)

      break unless result.next_page_token
      request = result.next_page
    end
    youtube_videos
  end

  def refresh_items
    videos.each do |youtube_video|
      unless items.where(guid: youtube_video.id.videoId).any?
        i = items.build(
          guid: youtube_video.id.videoId,
          title: youtube_video.snippet.title,
          description: youtube_video.snippet.description,
          link: ''
        )
      i.tags
      i.assets.build(url: youtube_video.snippet.thumbnails.high.url)
      end
    end
  end

  private

  def youtube
    @youtube ||= client.discovered_api('youtube', 'v3')
  end

end
