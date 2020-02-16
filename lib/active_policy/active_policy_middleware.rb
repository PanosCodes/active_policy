class ActivePolicyMiddleware
  # @param [Object] app
  def initialize(app)
    @app = app
  end

  # @param [Hash] env
  def call(env)
    params = ActivePolicy::Utilities.route_params(
        ActionDispatch::Request.new(env).path,
        env['REQUEST_METHOD'],
        Rails.application.routes
    )

    if params.key?(:policy)
      policy = params[:policy].new env['Warden']
      method_name = params[:action] + '?'
      models = ActivePolicy::Utilities.models_from_route_params(params[:policy_models])

      policy.send(method_name, *models)
    end

    @app.call(env)
  end

  private

  # @param [Hash] env
  # @return [User, nil]
  def current_user(env)
    if env.key?('Warden')
      return env['Warden'].user
    end

    nil
  end
end