require 'active_policy/active_policy_middleware'
module ActivePolicy
  class Railtie < Rails::Railtie
    initializer "railtie.configure_rails_initialization" do |app|
      app.middleware.use ActivePolicyMiddleware
    end
  end
end