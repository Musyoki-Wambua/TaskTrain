class UsersController < ApplicationController

    before_action :session_expired?, only: [:check_login_status]

    def register 
        user = User.create(user_params)
        if user.valid? 
            app_response(message: "Registration was successfull", status: :created, data: user )
        else 
            app_response(message: "Something went wrong during registration", status: :unprocessable_entity, data: user.errors )
        end

    end

    def login 
        sql  = "username = :username OR email = :email"
        user = User.where(sql, { username: user_params[:username], email: user_params[:email] }).first
        # user = User.find_by(username params[:username])
        if user&.authenticate(params(:password))
            save_user(id: user.id)
            app_response(message: 'Login was sucessfull', status: :ok, data: user)
        else 
            app_response(message: 'Invalid username or password', status: :unauthorized)
        end
    end

    def logout 
        remove_user
        app_response(message: 'Logout was sucessfull', status: :ok)
    end


    def  check_login_status 
        app_response(message: "Success", status: :ok)
    end


        

    private 

    def user_params 
        params.permit(:username, :email, :password)
    end
end
