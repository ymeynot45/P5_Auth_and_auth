# helpers do
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
    # TODO: return the current user if there is a user signed in.
  end
# end
