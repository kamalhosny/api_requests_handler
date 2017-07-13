module ApiRequestsHandler
  class Handler
    ## Attributes
    attr_accessor :method, :app_id, :retry_count

    ## Constructor
    def initilaize(method: 'get', app_id:, retry_count: 0, options: {})
      @method = method
      @app_id = app_id
      @retry_count = retry_count
      @options = options
      @response = http_request
    end

    ## Class Methods
    def self.to_env(name:, url:, token:)
      info = {
        url: url,
        token: token
      }

      File.open('/.env', 'a') do |file|
        file.write "mo{'#{name.upcase}':'#{info}'\n}"
      end
    end

    ## Instance Methods
    def http_request
      validate
      app_data = app_data_fetcher

      Request.new(method, app_data['url'], retry_count)
    end

    def validate
      valid_methods = %w[get post put delete]
      raise ArgumentError, "#{method} is not a valid method" unless valid_methods.include? method.downcase
      raise ArgumentError, "#{retry_count} is not a valid number (should be > 0)" if retry_count.negative?
      raise ArgumentError, "#{app_id} is not a valid application name " if ENV["#{app_id}_APP_ID"].nil?
    end

    def app_data_fetcher
      app_id = ENV["#{app_id}_APP_ID"]
      url    = ENV["#{app_id}_URL"]
      token  = ENV["#{app_id}_TOKEN"]
      Hash[:app_id, app_id, :url, url, :token, token]
    end
  end
end
