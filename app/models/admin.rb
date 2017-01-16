class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable,
  # :recoverable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  before_create :create_token_on_demand

  def create_token_on_demand
    self.API_token = Admin::create_random_token if !self.API_token
  end

  def self.create_random_token
    require 'digest/sha1'
    random_string = (0...8).map { (65 + rand(26)).chr }.join
    Digest::SHA1.hexdigest random_string
  end
end
