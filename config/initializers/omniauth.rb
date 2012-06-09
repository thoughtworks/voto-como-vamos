Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Settings.facebook_app_id, Settings.facebook_secret
end
