class ApplicationController < ActionController::API
    include ActionController::Cookies

    rescue_from StandardError, with: :standard_error

    def app_response(message: 'success', status: 200, data: nil)
        render json: {
            message: message,
            data: data
        }, status: status
    end

    #hash data into a web token
    def encode(uid, email)
        payload = {
            data: {
                uid: uid,
                email: email,
                role: 'admin'
            }, 
            exp: Time.now.to_i + (6 * 3600)
        }
        begin
            JWT.encode(payload, ENV['task_train_key'], 'HS256')
        rescue JWT::EncodeError => e 
            app_response(message: 'failed', status: 400, data: { info: 'Something went wrong. Please try again' })
        end        
    end

    #unhash our token 
    def decode(token)
        begin
            JWT.decode(token, ENV['task_train_key'], true, { algorithm: 'HS256' })
        rescue JWT::DecodeError => e
            app_response(message: 'failed', status: 401, data: { info: 'Your session has expired. Please login again to continue' })
        end
    end

    #vefiry authorization headers
    def verify_auth 
        auth_headers = request.headers['Authorization']
        if !auth_headers 
            app_response(message: 'failed', status: 401, data: { info: 'Your request is not authorized' })
        else
            token = auth_headers.split(' ')[1]
            save_user_uid(token)
        end
    end

    # store user id in session
    def save_user(id)
        session[:uid] = id
        session[:expiry] = 6.hours.from_now
    end

    # delete user id in session
    def remove_user
        session.delete(:uid)
        session[:expiry] = Time.now
    end

    # check for session expiry
    def session_expired?
        session[:expiry] ||= Time.now + 1.hour
        time_diff = (session[:expiry] - Time.now).to_i
        unless time_diff > 0
            app_response(message: 'failed', status: 401, data: { info: 'Your session has expired. Please login again to continue' })
        end
    end

    # save user's id
    def save_user_uid(token)
        @uid = decode(token)[0]["data"]["uid"].to_i
    end

    #get logged in user(session)
    def user
        User.find_by(@uid) 
    end
    
    # get logged in user(session)
    def user_session
        User.find_by(session[:uid].to_i) 
    end

    # rescue all common errors
    def standard_error(exception)
        app_response(message: 'failed', data: { info: exception.message }, status: :unprocessable_entity)
    end

end
