class User < ActiveRecord::Base
  #TODO : Use bcrypt to store hashed passwords and authenticate users



  def self.authenticate(email, password)
    @user = User.find_by_email(email)
    if @user && @user.password == password
      @user
    else
      nil
    end
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end
end
