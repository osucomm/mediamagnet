require 'google/api_client'
require 'google/api_client/auth/installed_app'

class YoutubePlaylistChannel < Channel

  def service_id_name
    'Playlist ID'
  end

  def icon
    'youtube-play'
  end

  def initial_keywords
    %w(video)
  end

  def uploads_playlist_id
    request = {
      api_method: youtube_api.channels.list,
      parameters: { part: 'contentDetails', mine: true }
    }

    result = client.execute(request)
    result.data.items.first.contentDetails.relatedPlaylists.uploads
  end

  def uploaded_video_ids
    request = {
      api_method: youtube_api.playlist_items.list,
      parameters: {part: 'snippet', 
                   playlistId: uploads_playlist_id,
                   maxResults: 10},
    }

    video_ids = []
    #loop do

      result = client.execute(request)

      result.data.items.each do |item|
        video_ids << item.snippet.resourceId.videoId
      end

      #break unless result.next_page_token
      #request = result.next_page
    #end

    video_ids
  end

  def uploaded_videos
    request = {
      api_method: youtube_api.videos.list,
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
    uploaded_videos.each do |youtube_video|
      unless items.where(guid: youtube_video.id).any?
        i = items.build(
          guid: youtube_video.id,
          title: youtube_video.snippet.title,
          description: youtube_video.snippet.description,
          content: "",
          link: Link.where(url: "https://www.youtube.com/watch?v=#{youtube_video.id}").first_or_create,
          published_at: youtube_video.snippet.published_at,
          digest: Digest::SHA256.base64digest(youtube_video.snippet.title.to_s+youtube_video.snippet.description.to_s+youtube_video.snippet.thumbnails.high.url.to_s)
        )
        i.tag_names = youtube_video.snippet.tags
        i.keywords << all_keywords
        i.assets.create(url: youtube_video.snippet.thumbnails.high.url)
        i.update_es_record
      end
    end
    log_refresh
  end

  def load_service_identifier
    self.service_identifier = uploads_playlist_id if new_record?
  end

  def service_url
    "https://www.youtube.com/playlist?list=#{service_identifier}"
  end

  private

  def youtube_api
    @youtube_api ||= client.discovered_api('youtube', 'v3')
  end

  def client
    @client ||= (
      Google::APIClient.new
    )

    @client.authorization.access_token = token.fresh_token
    @client
  end

  def service_account
    # TO make valud
    true 
  end

end
