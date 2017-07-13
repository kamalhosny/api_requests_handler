module ApiRequestsHandler
  class Handler
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

      Request.new(@method, @retry_count, @options)
    end

    def validate
      valid_methods = %w[get post put delete]
      raise ArgumentError, "#{@method} is not a valid method" unless valid_methods.include? @method.downcase
      raise ArgumentError, "#{@retry_count} is not a valid number (should be > 0)" if @retry_count.negative?
    end

    def nameless
      case @app_id
      when 'core'
        app_url = ENV['CORE_BASE_URL']
        app_token = ENV['CORE_TOKEN']
      end

    end

  end
end
