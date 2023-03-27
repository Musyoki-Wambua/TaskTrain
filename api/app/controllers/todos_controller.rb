class TodosController < ApplicationController
    before_action :session_expired?

    # def create 
    #     if params[:uid]
    #         user = User.find_by(id: params[:id])
    #         if user 
    #             todo = Todo.create(todo_params)
    #             if todo.valid?
    #                 app_response(status: :created, data: todo)
    #             else
    #                 app_response(status: :unprocessable_entity, data: todo.errors, message: 'failed')
    #             end
    #         else 
    #             render json: { message: "Not authorized" }, status: :unauthorized
    #         end
    #     else 
    #         render json: { message: "Not authorized" }, status: :unauthorized
    #     end
    # end

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
            app_response(data: { info: 'updated todo successfully' })
        else
            app_response(message: 'failed', data: { info: 'something went wrong. could not update todo' }, status: :unprocessable_entity)
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
