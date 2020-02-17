module ActivePolicy
  class Utilities
  # @param [ActionDispatch::Routing::RouteSet] route_set
  # @param [String] path
  # @param [String] method
  #
  # @return [Hash]
  def self.route_params(path, method, route_set)
    route_set.recognize_path(path, {method: method})
  end

  # @param [Hash] params
  #
  # @return [Array<ActiveRecord>]
  def self.models_from_route_params(params)
    models = []
    raise 'policy_models is missing from route' if params[:policy_models].nil?
    return [] if params[:policy_models].empty?
    params[:policy_models].each do |key, value|
      models << value.find(params[key])
    end
    models
  end
  end
end
