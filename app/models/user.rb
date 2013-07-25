class User < ActiveRecord::Base
  #TODO : Use bcrypt to store hashed passwords and authenticate users
  validates :name, :email, presence: :true
  validates :email, uniqueness: :true
  validates :email, format: {with: /\b[&.+.A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,6}/, message: "Please enter a valid email address."}
  #validates :raw_password, :length => {:minimum => 6}

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && user.password == password
      user
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
    #self.raw_password = new_password
  end

  def self.human_attribute_name(attribute, options = {})
    if attribute == :raw_password
      return 'Password'
    else
      super #explicitly call super so that any attribute other than raw_password
    end
  end
end
