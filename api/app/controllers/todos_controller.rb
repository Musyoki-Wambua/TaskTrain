class TodosController < ApplicationController
    before_action :session_expired?
    
    def create
       todo =  user.todos.create(todo_params)
       if todo.valid? 
        app_response(status: :created, data: todo)
       else
        app_response(message: "Failed creating a Todo", data: todo.errors, status: :unprocessable_entity )
       end
    end

    def update 
        todo = user.todos.find(params[:id]).update((todo_params))
        if todo 
        app_response(status: :ok, data: { info: "Updated todo sucessfully" })
    else 
        app_response(message: "failed", data: { info: "Something went wrong.Could not update Todo" }, status: :unprocessable_entity)

        end
    end

    def destroy 
        user.todos.find(params[:id]).destroy
        app_response(message: 'success', data: {info: "deleted sucessfully"}, status: 204)
    end

    def index 
        todos = user.todos.all 
        app_response(message: "Success", data: todos)
    end

    private 

    def todo_params
        params.permit(:title, :description, :status, :priority)
    end

end
