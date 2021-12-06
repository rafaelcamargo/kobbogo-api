require 'rails_helper'

RSpec.describe "Todos routes", type: :routing do
  it 'should contain a route to save a todo' do
    expect(post '/todos').to route_to(
      :controller => 'todos',
      :action => 'create'
    )
  end
end
