class Guest < ActiveRecord::Base
  has_many :presents, dependent: :destroy

  enum participating: {
    participating: '3',
    not_sure: '2',
    turned_down: '1',
    undecided: '0'
  }

  validates :companions,
    numericality: {
      only_integer: true,
      greater_than_or_equal_to: 0,
      less_than_or_equal_to: 5
    }
  validates :notice,
    length: { maximum: 320 }
end
