module HttpAwesome
  class Request
    ## Attributes
    attr_accessor :method, :app, :retry_count, :data, :headers, :response

    ## Constructor
    def initialize(method: :get, app:, retry_count: 0, data: {}, headers: {}, &success_block)
      @method = method
      @app = app.to_s.upcase
      @retry_count = retry_count
      @data = data
      @headers = headers
      @success_block = success_block
      @response = http_request
    end

    private

    ## Instance Methods
    def http_request
      validate
      app_data = app_data_fetcher

      app_data[:headers].each do |key, value|
        headers.merge!(Hash[key, value]) unless value.nil?
      end

      begin
        Logger.new(STDOUT).info 'Sending request...'
        request = Execute.new(method, app_data[:url], retry_count, data, headers)

        if request.response.is_a? Net::HTTPSuccess
          @success_block.call if block_given?
          return request.parsed_response
        end
        raise "#{request.response.code} #{request.response.message}"
      rescue StandardError => e
        Logger.new(STDOUT).error e.message

        if @retry_count.positive?
          @retry_count -= 1
          Logger.new(STDOUT).info 'Retrying...'
          sleep 2
          retry
        end
      end
    end

    def validate
      valid_methods = %i[get post put patch delete]
      raise ArgumentError, "#{method} is not a valid method" unless valid_methods.include? method.downcase
      raise ArgumentError, "#{retry_count} is not a valid number (should be > 0)" if retry_count.negative?
      # this must be changed later
      raise ArgumentError, 'make sure the name you are entering matches the name in .env file' if ENV["#{app}_URL"].nil?
    end

    def app_data_fetcher
      app_id = ENV["#{app}_APP_ID"]
      url    = ENV["#{app}_URL"]
      token  = ENV["#{app}_TOKEN"]

      Hash[:headers, { app_id: app_id, token: token }, :url, url]
    end
  end
end
