module ActivePolicy
  class Base
    # @param [User] current_user
    def initialize(current_user)
      @current_user = current_user
    end
  end
end
