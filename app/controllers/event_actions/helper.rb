module EventActions::Helper
  def render_event(event)
    %Q(
    Name: #{event.name}
    Date: #{event.date.to_formatted_s(:long)}
    Users: #{event.users.map(&:usertag).join(' ')}
    <b>/join_event #{event.id}</b> => to join event_actions
    )
  end
end