require 'active_policy/utilities/utilities'
class ActivePolicyMiddleware
  ENV_KEY_REQUEST_METHOD = 'REQUEST_METHOD'
  ENV_KEY_WARDEN = 'warden'

  # @param [Class] app
  def initialize(app)
    @app = app
  end

  # @param [Hash] env
  def call(env)
    request = ActionDispatch::Request.new(env)
    params = ActivePolicy::Utilities.route_params(
        request.path,
        env[ENV_KEY_REQUEST_METHOD],
        Rails.application.routes
    )

    if params.key?(:policy)
      # @type [ActivePolicy::Base] policy
      policy = params[:policy].new(current_user(env), request, params)
      method_name = params[:action] + '?'
      models = ActivePolicy::Utilities.models_from_route_params(params)
      result = policy.send(method_name, *models)

      if result
        @app.call(env)
      else
        response = response()
        response.finish
      end
    else
      @app.call(env)
    end
  end

  private

  # @param [Hash] env
  #
  # @return [User, nil]
  def current_user(env)
    if env.key?(ENV_KEY_WARDEN)
      return env[ENV_KEY_WARDEN].user
    end

    nil
  end

  # @param [Rack::Response]
  def response(status_code = 401, headers = {'content_type': 'application/json'}, body = [])
    Rack::Response.new(body, status_code, headers)

  # @param [Hash] params
  # @return [TrueClass, FalseClass]
  def run_middleware?(params)
    params.key?(:policy)
  end
end