class ApplicationController < ActionController::API
  def default_url_options
    { host: '192.168.88.69', port: 3000 }
  end
end
