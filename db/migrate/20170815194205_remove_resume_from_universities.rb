class RemoveResumeFromUniversities < ActiveRecord::Migration[5.1]
  def change
    remove_reference :universities, :resume, foreign_key: true
  end
end
