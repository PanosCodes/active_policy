require_relative '../spec_helper'

RSpec.describe ActivePolicy::Utilities do
  describe '#route_params' do
    it 'should return the params returned from #recognize_path' do
      route_set =  Class.new
      allow(route_set).to receive(:recognize_path).and_return({controller: 'users', action: 'edit'})
      result = ActivePolicy::Utilities.route_params('users/:user_id/segments', 'get', route_set)

      expect(result).to be_eql({:controller => 'users', :action => 'edit'})
    end
  end
  describe '#models_from_route_params' do
    it 'should return a hash with key the url parameter and value the model instance' do
      model = Class.new
      allow(model).to receive(:find).and_return(Class.new)
      result = ActivePolicy::Utilities
          .models_from_route_params({user_id: model, segment_id: model})

      expect(result.length).to eq 2
    end
  end
end