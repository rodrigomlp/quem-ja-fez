desc "Ping our heroku dyno every 10, 60 or 3600 min"
task :start => :environment do

  # Meetgins que vão aconter nas próximas 24hrs
  @next_meetings = Meeting.where('start_time >= ? AND end_time <= ?', Date.tomorrow.beginning_of_day, Date.tomorrow.end_of_day)
  puts "The number of meetings in the next 24 hours is #{@next_meetings.size}"

  # Disparando email para os users das next meetings
  @next_meetings.each_with_index do |meeting, index|
    puts "Sending emails for the meeting #{index + 1}"
    UserMailer.remember_highschooler(meeting).deliver_now
    UserMailer.remember_undergraduate(meeting).deliver_now
  end
end

