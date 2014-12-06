require 'google/api_client'
require 'google/api_client/auth/installed_app'

class YoutubeChannel < Channel


  def service_id_name
    'Uploads Channel Id'
  end

  def icon
    'youtube-play'
  end

  def uploads_playlist_id
    request = {
      api_method: youtube.channels.list,
      authorization: google_authorization.user_credentials.to_json,
      parameters: { part: 'contentDetails' }
    }

    result = client.execute(request)
    result.data.items.first.contentDetails.relatedPlaylists.uploads
  end

  def uploaded_video_ids
    request = {
      api_method: youtube.playlistItems.list,
      authorization: google_authorization.user_credentials.to_json,
      parameters: {part: 'snippet', playlistId: uploads_playlist_id}
    }

    video_ids = []
    loop do
      result = client.execute(request)

      result.data.items.each do |item|
        video_ids << item.contentDetails.videoId
      end

      break unless result.next_page_token
      request = result.next_page
    end

    youtube_videos
  end

  def uploaded_videos
    request = {
      api_method: youtube.playlistItems.list,
      authorization: google_authorization.user_credentials.to_json,
      parameters: {part: 'snippet', id: uploaded_video_ids.join(',') }
    }

    videos = []
    loop do
      result = client.execute(request)

      videos.concat(result.data.items)

      break unless result.next_page_token
      request = result.next_page
    end

    videos
  end


  def refresh_items
    videos.each do |youtube_video|
      unless items.where(guid: youtube_video.id.videoId).any?
        i = items.build(
          guid: youtube_video.id.videoId,
          title: youtube_video.snippet.title,
          description: youtube_video.snippet.description,
          link: 'https://www.youtube.com/watch?v=' + youtube_video.id.videoId,
          published_at: Date.strptime(youtube_video.snippet.published_at, '%s')
        )
        i.tag_names = youtube_video.snippet.tags
        i.assets.build(url: youtube_video.snippet.thumbnails.high.url)
      end
    end
  end

  private

  def youtube
    @youtube ||= client.discovered_api('youtube', 'v3')
  end

  private

  def set_keywords
    keywords << Keyword.where(name: 'video').first
  end

end
