module UserActions::Callbacks::RefillBorrower
  def refill_borrower_callback_query(borrower_id = nil, *)
    session[:borrower] = User.find borrower_id
    save_context :refill_borrower
    bot.send_message chat_id: current_user.chat_id, text: t('.success'), alert: true
  end

  def refill_borrower(*args)
    return unless current_user.chat_id == payload['chat']['id']

    operation = Refill::Operation::Create.call(
      current_user: current_user,
      params: { from_user: session[:borrower], to_user: current_user, value: args.first.to_f }
    )
    if operation.success?
      bot.send_message chat_id: current_user.chat_id, text: t('.success')
    else
      bot.send_message chat_id: current_user.chat_id, text: render_errors(operation)
    end
  end
end

