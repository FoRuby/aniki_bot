module EventActions::Helper
  def render_event_header(event)
    date = event.date.to_formatted_s(:long)
    users = event.users&.map(&:usertag).join(' ') || ''
    "Event info: \n" +
    "Name: #{event.name} \n" +
    "Date: #{date} \n" +
    "Users: #{users} \n"
  end

  def render_event_bank(event)
    date = event.date.to_formatted_s(:long)
    users = event.user_events.map { |i| "#{i.user.usertag} => #{i.payment.format} \n" }.join || 'No one pay'
    "Event info: \n" +
    "Name: #{event.name} \n" +
    "Date: #{date} \n" +
    "Bank: \n" +
    users
  end
end