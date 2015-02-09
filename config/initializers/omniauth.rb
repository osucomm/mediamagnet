Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'],
    :scope => 'email,user_birthday,read_stream', :display => 'popup'

  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    scope: 'email,profile,youtube.readonly'
  }

  provider :shibboleth, {
    :uid_field  => 'eppn',
    :name_field => "displayName",
    :info_fields => {
      :email      => "mail",
      :first_name => "givenName",
      :last_name  => "sn"
    }
  }
end
