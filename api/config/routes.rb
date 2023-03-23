Rails.application.routes.draw do
  #user 
  post '/users', to: 'users#register'
  post '/users/login', to: 'users#login'
  get '/user/login/check', to: 'users#check_login_status'
  delete '/users/logout', to: 'users#logout'

end
