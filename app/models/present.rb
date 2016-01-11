class Present < ActiveRecord::Base
  belongs_to :guest

  validates :guest,
    presence: true
  validates :description,
    presence: true,
    length: { maximum: 140 }
end
