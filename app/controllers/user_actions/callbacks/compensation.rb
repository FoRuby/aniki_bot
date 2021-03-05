module UserActions::Callbacks::Compensation
  def compensation_callback_query(opponent_id = nil, *)
    operation = Debt::Operation::Compensation.call(current_user: current_user, params: { opponent_id: opponent_id })
    if operation.success?
      message =
        "Compensation between #{current_user.tag} and #{operation[:opponent].tag} complete. Compensation sum = #{operation[:compensation].format}"
      bot.send_message chat_id: current_user.chat_id, text: message
      bot.send_message chat_id: operation[:opponent].chat_id, text: message
    else
      message1 =
        "#{current_user.tag} trying to compensate a debt. Select /me => Compensation => #{current_user.tag} to complete action"
      message2 =
        "Sending message to #{operation[:opponent].tag} to complete action"
      bot.send_message chat_id: operation[:opponent].chat_id, text: message1
      bot.send_message chat_id: current_user.chat_id, text: message2
    end
  end
end

