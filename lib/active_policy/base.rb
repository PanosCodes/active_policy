module ActivePolicy
  class Base
    def initialize(current_user)
      @current_user = current_user
    end
  end
end
