class Guest < ActiveRecord::Base
  enum participating: {
    participating: '3',
    not_sure: '2',
    turned_down: '1',
    undecided: '0',
  }
end
