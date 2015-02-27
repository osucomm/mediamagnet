module AssetsHelper

  def render_asset(asset, custom_class=nil)
    case(asset.mime.split('/').first)
    when 'image'
      content_tag(:img, nil, src: asset.url, alt: asset.alt, title: asset.title, class: ['media-object', custom_class].join(' '))
    when 'video'
      content_tag(:video, nil, src: asset.url, controls: true)
    else
      link_to asset.url, asset.url
    end
  end

end
