module ApiRequestsHandler
  class Handler
    ## Attributes
    attr_accessor :method, :app, :retry_count, :data, :headers, :response

    ## Constructor
    def initialize(method: :get, app: nil, retry_count: 0, data: {}, headers: {})
      @method = method
      @app = app.upcase
      @retry_count = retry_count
      @data = data
      @headers = headers
      @response = http_request
    end

    ## Instance Methods
    def http_request
      validate
      app_data = app_data_fetcher
      headers.merge!(token: app_data[:token], app_id: app_data[:app_id])
      Request.new(method, app_data[:url], retry_count, headers, data)
    end

    def validate
      valid_methods = %i[get post put patch delete]
      raise ArgumentError, "#{method} is not a valid method" unless valid_methods.include? method.downcase
      raise ArgumentError, "#{retry_count} is not a valid number (should be > 0)" if retry_count.negative?
      # this must be changed later

      raise ArgumentError, "#{app} is not a valid application name " if ENV["#{app}_APP_ID"].nil?
    end

    def app_data_fetcher
      app_id  = ENV["#{app}_APP_ID"]
      url     = ENV["#{app}_URL"]
      token   = ENV["#{app}_TOKEN"]
      Hash[:app_id, app_id, :url, url, :token, token]
    end
    ## Class Methods
    # def self.to_env(name:, url:, token:)
    #   info = {
    #     url: url,
    #     token: token
    #   }
    #
    #   File.open('/.env', 'a') do |file|
    #     file.write "{'#{name.upcase}':'#{info}'\n}"
    #   end
    # end
  end
end
