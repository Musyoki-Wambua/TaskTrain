class TodosController < ApplicationController
    # before_action :session_expired?
    before_action :verify_auth

    def create
        todo = user.todos.create(todo_params)
        if todo.valid?
            app_response(status: :created, data: todo)
        else
            app_response(status: :unprocessable_entity, data: todo.errors, message: 'failed')
        end
    end

    def update
        todo = user.todos.find(params[:id]).update(todo_params)
        if todo
            app_response(message: { info: 'updated todo successfully' }, data: todo)
        else
            app_response(message: 'failed', error: { info: 'something went wrong. could not update todo' }, data: todo.errors, status: :unprocessable_entity)
        end
    end

    def destroy
        user.todos.find(params[:id]).destroy
        app_response(message: 'success', data: { info: 'deleted todo successfully' }, status: 204)
    end

    def index
        todos = user.todos.all
        app_response(message: 'success', data: todos)
    end

    private

    def todo_params
        params.permit(:title, :description, :status, :priority)
    end

end
