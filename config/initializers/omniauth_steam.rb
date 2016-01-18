Rails.application.config.middleware.use OmniAuth::Builder do
  provider :steam, ENV.fetch("STEAM_API_KEY")
end
