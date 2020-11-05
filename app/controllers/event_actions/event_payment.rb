module EventActions::EventPayment
  def event_payment!(*args)
    interactor = EventPayment.call(user: current_user, event_id: args.first, payment: args.second)
    if interactor.success?
      message = render_payment(current_user: current_user, user_event: interactor.user_event)
      reply_with :message, text: t('.success', message: message)
    else
      render_errors interactor.errors
    end
  end

  def render_payment(user_event:, current_user:)
    "#{current_user.usertag} pay #{user_event.payment.format} for Event #{user_event.event_id}"
  end
end