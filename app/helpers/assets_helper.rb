module AssetsHelper

  def render_asset(asset,custom_class)
    case(asset.mime.split('/').first)
    when 'image'
      content_tag(:img, nil, src: asset.url, alt: asset.alt, title: asset.title, class: 'media-object '+custom_class)
    else
      link_to asset.url, asset.url
    end
  end

end
