module ActivePolicy
  class Base
    # @param [User] current_user
    # @param [ActionDispatch::Request]
    def initialize(current_user, request, params)
      @current_user = current_user
      @request = request
      @params = params
    end

    # @param [Rack::Response]
    def response(status_code, headers = {'content_type': 'application/json'}, body = [])
      Rack::Response.new(body, status_code, headers)
    end
  end
end
