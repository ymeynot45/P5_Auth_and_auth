# Fixes Needed
# Extra: set up the links for the student editing
# and add a form field to put in a password that would raise your clearance to 2.

get '/' do

  if current_user
    @users = User.all
  end
  erb :index

end

#----------- SESSIONS -----------

get '/sessions/new' do
  @user = User.new
  erb :sign_in
end

post '/sessions' do
  # sign-in
  @user = User.authenticate(params[:user][:email], params[:user][:password])
  if @user
    session[:user_id] = @user.id
    redirect to "/"
  else
    @errors = "Username or Email entries were invalid." #hard coded so that they can't tell which one failed. Stops phishing.
    erb :sign_in
  end

end

delete '/sessions/:id' do
  session[:user_id] = nil
  erb :sign_up
  # sign-out -- invoked via AJAX
end

#----------- USERS -----------

get '/users/new' do
  # render sign-up page
  @user = User.new
  erb :sign_up
end

post '/users' do
  @user = User.new(params[:user])
  if @user.valid?
    @user.save
    session[:user_id] = @user.id
    redirect to "/"
  else
    @errors = @user.errors.messages
    erb :sign_up
  end
end