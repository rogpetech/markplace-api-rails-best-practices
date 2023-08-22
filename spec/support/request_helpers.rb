module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module HeadersHelpers
    def api_authorization_header(token)
      request.headers['Authorization'] = token
    end

    def api_header(version = 1)
      request.headers['Accept'] = "application/vnd.marketplace.#{version}"
    end

    def api_response_format(format = 'application/json')
      request.headers['Accept'] = "#{request.headers['Accept']},#{format}"
      request.headers['Content-Type'] = format
    end

    def include_default_accpet_headers
      api_header
      api_response_format
    end
  end
end
