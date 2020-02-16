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
  def self.models_from_route_params(policy_model_map)
    models = []
    policy_model_map.each do |key, value|
      models << value.find(policy_model_map[key])
    end
    models
  end
  end
end