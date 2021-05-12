module Event::Render
  class Info < Event::Render::Base
    def render
      { text: text, chat_id: current_user.chat_id }
    end

    def text
      "Event info:\n" \
      "ID: #{event.id}\n" \
      "Name: #{event.name}\n" \
      "Status: #{event.status}\n" \
      "#{event.description.present? ? "Description: \n#{event.description}\n" : ''}" \
      "Date: #{event.date.to_formatted_s(:long)}\n" \
      "Admins(#{event.admins.count}): #{event.admins.map(&:tag).join(' ')}\n" \
      "Users(#{event.users.count}): #{event.users.map(&:tag).join(' ')}\n" \
      "Bank: #{event.bank.format}\n".concat(payments)
    end

    def payments
      required_payment = event.required_payment.format
      str = event.user_events.includes(:user).map do |i|
        "#{i.user.tag} | #{i.payment.format} (#{required_payment})"
      end.join("\n")
      str.present? ? str.prepend("Payments:\n") : 'There are no users in the event'
    end

    def description
      event.description.present? ? "Description: #{event.description}\n" : ''
    end
  end
end