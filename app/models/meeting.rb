class Meeting < ApplicationRecord

  belongs_to :undergraduate, class_name: 'User'#, foreign_key: 'undergraduate_id'
  belongs_to :highschooler, class_name: 'User'#, foreign_key: 'highschooler_id'

end
