require 'sinatra'
require 'json'

class CIServer < Sinatra::Base
  configure :production, :development do
    enable :logging
  end

  post '/event_handler' do
    @payload = JSON.parse(params[:payload])

    logger.info "request:#{request.env['HTTP_X_GITHUB_EVENT']}"

    case request.env['HTTP_X_GITHUB_EVENT']
    when "push"
      logger.info "start pulling and building"
      system "cd /home/erl/workspace/persephone; git pull; jekyll b"
    end
  end
end
