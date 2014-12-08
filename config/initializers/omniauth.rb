OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '332657301502-eioq9rnf9nrvlg9auijkluoej0dmo34n.apps.googleusercontent.com', 'KZs9vnD7ZCcflruy2rMHNISD', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
