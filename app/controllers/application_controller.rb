class ApplicationController < ActionController::API
  def default_url_options
    { host: ENV['API_HOST'], port: ENV['API_PORT'] }
  end
end
