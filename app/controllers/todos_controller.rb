class TodosController < ApplicationController
  before_action :authorize_request

  def index
    todos = Todo.where(user_id: @current_user.id)
    render json: todos.map { |todo| format(todo) }, status: :ok
  rescue StandardError => e
    render json: { errors: e.message }, status: :internal_server_error
  end

  def create
    todo = Todo.new({ description: params[:description], user_id: @current_user.id })
    if todo.save
      render json: format(todo), status: :created
    else
      render json: { errors: todo.errors.full_messages }, status: :bad_request
    end
  rescue StandardError => e
    render json: { errors: e.message }, status: :internal_server_error
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy
    render status: :ok
  rescue StandardError => e
    render json: { errors: e.message }, status: :not_found
  end

  private

  def format(todo)
    todo.as_json.reject { |key| key == 'user_id' }
  end
end
