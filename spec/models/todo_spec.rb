require 'rails_helper'

RSpec.describe Todo, type: :model do
  it 'should be invalid if no description has been provided' do
    todo = build(:todo, description: '')
    expect(todo).not_to be_valid
    expect(todo.errors[:description]).to include("can't be blank")
  end
end
