Rails.application.config.middleware.use OmniAuth::Builder do
  facebook_app_id = ENV['FACEBOOK_APP_ID'] || Settings.facebook_app_id
  facebook_secret = ENV['FACEBOOK_SECRET'] || Settings.facebook_secret
  provider :facebook, facebook_app_id, facebook_secret
end
