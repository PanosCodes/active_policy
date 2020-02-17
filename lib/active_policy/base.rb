module ActivePolicy
  class Base
    # @param [User] current_user
    # @param [ActionDispatch::Request]
    def initialize(current_user, request, params)
      @current_user = current_user
      @request = request
      @params = params
    end
  end
end
