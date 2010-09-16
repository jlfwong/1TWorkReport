class User < ActiveRecord::Base
  attr_accessor :password_raw

  has_many :blog_posts

  validates :username,  :uniqueness => true,
                        :length     => 5..25,
                        :format     => /\A[a-zA-Z0-9_]+\Z/

  validates :password,  :length     => 40..40,
                        :format     => /\A[a-z0-9]+\Z/
  
  before_validation :generate_hash

  def self.password_hash(username,password)
    Digest::SHA1.hexdigest "#{username}:#{password}"
  end

  def self.authenticate(username,password)
    User.where(
      :username => username,
      :password => User.password_hash(username,password)
    ).first
  end

  def generate_hash
    self.password = User.password_hash(
      self.username,
      self.password_raw
    )
  end
end
