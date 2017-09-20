class Event < ApplicationRecord
  belongs_to :user


  def date
    return "#{self.start.day}/#{self.start.month}"
  end

  def start_time
    return "#{'%02d' % self.start.hour}:#{'%02d' % self.start.min}"
  end

  def end_time
    return "#{'%02d' % self.end.hour}:#{'%02d' % self.end.min}"
  end
end

