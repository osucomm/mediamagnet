module AssetsHelper

  def render_asset(asset)
    case(asset.mime.split('/').first)
    when 'image'
      content_tag(:img, nil, src: asset.url, alt: asset.alt, title: asset.title, class: 'media-object')
    else
      link_to asset.url, asset.url
    end
  end

end
