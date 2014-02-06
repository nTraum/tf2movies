Rails.application.config.middleware.use OmniAuth::Builder do
  provider :steam, 'FOO_BAR'
end