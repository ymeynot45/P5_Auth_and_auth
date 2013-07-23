#!!!! TOOK ABOUT AN HOUR!!!!! not good. V1


get '/' do

  if current_user
    @users = User.all
  end
  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page
  erb :sign_in
end

post '/sessions' do
  # sign-in
  user = User.authenticate(params[:user][:email], params[:user][:password])
  if user
    session[:user_id] = user.id
    redirect to "/"
  else
    #@errors
    redirect to "/sessions/new"
  end

end

delete '/sessions/:id' do
  user = User.find(params[:id])
  user.delete
  session[:user_id] = nil
  erb :sign_up
  # sign-out -- invoked via AJAX
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  erb :sign_up
end

post '/users' do
  user = User.new(params[:user])
    if user.valid?
      session[:user_id] = user.id
      user.save
      redirect to "/"
    else
      #@errors
      redirect to "/users/new"
    end
end
