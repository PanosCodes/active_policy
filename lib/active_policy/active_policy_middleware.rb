require 'active_policy/utilities/utilities'
class ActivePolicyMiddleware
  ENV_KEY_REQUEST_METHOD = 'REQUEST_METHOD'
  ENV_KEY_WARDEN = 'warden'

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

    return next_middleware(env) unless run_middleware?(params)

    method_name = method_name_from_params(params)
    models = ActivePolicy::Utilities.models_from_route_params(params)
    policy = policy_name(params).new(current_user(env), request, params)

    return next_middleware(env) unless policy.respond_to?(method_name)

    result = policy.send(method_name, *models)

    return next_middleware(env) if result

    response
  end

  private

  # @param [Hash] params
  # @return [String]
  def method_name_from_params(params)
    return params[:method] if params.key(:method)

    params[:action] + '?'
  end

  # @param [Hash] params
  # @return [String]
  def policy_name(params)
    if params[:policy].is_a?(Class)
      return params[:policy]
    end

    if params[:policy].key?(:class)
      return params[:policy][:class]
    end

    params[:policy]
  end

  # @param [Hash] env
  # @return [User, nil]
  def current_user(env)
    if env.key?(ENV_KEY_WARDEN)
      return env[ENV_KEY_WARDEN].user
    end

    nil
  end

  # @param [Rack::Response]
  def response(status_code = 401, headers = {'content_type': 'application/json'}, body = [])
    Rack::Response.new(body, status_code, headers).finish
  end

  # @param [Hash] env
  def next_middleware(env)
    @app.call(env)
  end

  # @param [Hash] params
  # @return [TrueClass, FalseClass]
  def run_middleware?(params)
    params.key?(:policy)
  end
end