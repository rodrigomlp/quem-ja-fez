class Meeting < ApplicationRecord

  belongs_to :undergraduate, class_name: 'User'
  belongs_to :highschooler, class_name: 'User'


end
