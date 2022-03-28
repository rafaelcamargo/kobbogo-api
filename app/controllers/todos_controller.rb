class TodosController < ApplicationController
  def index
    render json: Todo.all, status: 200
  rescue => e
    render json: { errors: e.message }, status: 500
  end

  def create
    @todo = Todo.new({ :description => params[:description] })
    if @todo.save
      render status: 201
    else
      render json: { errors: @todo.errors.full_messages }, status: 400
    end
  rescue => e
      render json: { errors: e.message }, status: 500
  end
end