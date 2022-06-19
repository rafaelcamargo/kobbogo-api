class TodosController < ApplicationController
  before_action :authorize_request

  def index
    todos = Todo.where(:user_id => @current_user.id)
    render json: todos.map { |todo| format(todo) }, status: 200
  rescue => e
    render json: { errors: e.message }, status: 500
  end

  def create
    @todo = Todo.new({ :description => params[:description], :user_id => @current_user.id })
    if @todo.save
      render json: format(@todo), status: 201
    else
      render json: { errors: @todo.errors.full_messages }, status: 400
    end
  rescue => e
    render json: { errors: e.message }, status: 500
  end

  def destroy
    @todo = Todo.find(params[:id])
    if @todo.destroy
      render status: 200
    end
  rescue => e
    render json: { errors: e.message }, status: 404
  end

  private

  def format todo
    todo.as_json.reject { |key| key == 'user_id' }
  end
end
