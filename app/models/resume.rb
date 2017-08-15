class Resume < ApplicationRecord
  STANCE = [-1, 0, 1]

  belongs_to :university
  belongs_to :course
  belongs_to :user
end
