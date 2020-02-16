module ActivePolicy
  class Base
    # @param [User] current_user
    # @param [ActionDispatch::Request]
    def initialize(current_user, request)
      @current_user = current_user
      @request = request
    end
  end
end
