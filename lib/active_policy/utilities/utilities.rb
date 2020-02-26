module ActivePolicy
  class Utilities
  # @param [String] path
  # @param [String] method
  # @param [ActionDispatch::Routing::RouteSet] route_set
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
    if params.key?(:policy_models)
      params[:policy_models].each do |key, value|
        models << value.find(params[key])
      end
    end
    models
  end
  end
end
