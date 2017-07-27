require "readmeio/version"
require 'net/http'
require 'uri'
require 'json'


module Readmeio
  class Api
    API_PATH = "https://api.readme.build/v0/services/"
    HTTP_OPEN_TIMEOUT = 5

    def config(api_key, password='')
      @api_key = api_key
      @password = ''
    end

    def run(service, method, data={})
      begin
        organization, service, version_override = generate_api_url_parts(service)
        service_full = "#{organization}/#{service}"
        path = "#{API_PATH}#{service_full}/#{method}/invoke"

        url = URI(path)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.open_timeout = HTTP_OPEN_TIMEOUT

        request = Net::HTTP::Post.new(url)
        request = prepare_headers(request, version_override)
        request.basic_auth @api_key, @password
        request.body = data.to_json
        response = http.request(request)

        case response.code
          when '200'
            return response.body
          when '404', '400'
            return JSON.parse(response.body)
          else
            return response.body
        end
      rescue Exception => e
        return e.message
      end
    end

    private
    def prepare_headers(request, version_override)
      request["content-type"] = 'application/json'
      request.add_field 'X-Build-Meta-Language', "ruby@#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
      request.add_field 'X-Build-Meta-SDK', "api@#{Readmeio::VERSION}"
      request.add_field 'X-Build-Meta-OS', RUBY_PLATFORM
      request.add_field 'X-Build-Version-Override', version_override if version_override
      request
    end

    def generate_api_url_parts(service)
      #split = /(?:([-\w]+)\/)?([-\w]+)(?:@([-.\w]+))?/.match('@twitter/math@v2.0').to_a
      split = /(?:([-\w]+)\/)?([-\w]+)(?:@([-.\w]+))?/.match(service).to_a
      organization = split[1]
      service = split[2]
      version_override = split[3]
      return organization, service, version_override
    end
  end
end