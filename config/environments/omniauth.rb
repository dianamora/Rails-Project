#Processing our outgoing request - making sure it's suitable for our 3rd party
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], :skip_jwt => true
end
require './lib/token_verifier'
  OmniAuth.config.request_validation_phase = TokenVerifier.new