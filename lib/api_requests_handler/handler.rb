module ApiRequestsHandler
  class Handler
    ## Attributes
    attr_accessor :method, :app, :retry_count, :data, :headers, :response

    ## Constructor
    def initialize(method: :get, app:, retry_count: 0, data: {}, headers: {})
      @method = method
      @app = app
      @retry_count = retry_count
      @data = data
      @headers = headers
      @response = http_request
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

    ## Instance Methods
    def http_request
      validate
      app_data = app_data_fetcher

      # headers.merge!(token: app_data[:token], app_id: app_data[:app_id])
      puts "Sending request..."
      request = Request.new(method, app_data[:url], retry_count, data, headers)
      request.parsed_response
    end

    def validate
      valid_methods = %i(get post put patch delete)
      raise ArgumentError, "#{method} is not a valid method" unless valid_methods.include? method.downcase
      raise ArgumentError, "#{retry_count} is not a valid number (should be > 0)" if retry_count.negative?
      # this must be changed later
      # raise ArgumentError, "#{app} is not a valid application name " if ENV["#{app}_APP_ID"].nil?
    end

    def app_data_fetcher
      app_id = ENV["#{app.to_s.upcase}_APP_ID"]
      url    = ENV["#{app.to_s.upcase}_URL"]
      token  = ENV["#{app.to_s.upcase}_TOKEN"]
      Hash[:app_id, app_id, :url, url, :token, token]
    end
  end
end
