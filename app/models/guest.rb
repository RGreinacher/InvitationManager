class Guest < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable,
  # :recoverable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable
  has_many :presents, dependent: :destroy

  enum participating: {
    participating: 3,
    not_sure: 2,
    turned_down: 1,
    undecided: 0
  }

  validates :companions,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 3
    }
  validates :notice,
    length: { maximum: 320 }
end
