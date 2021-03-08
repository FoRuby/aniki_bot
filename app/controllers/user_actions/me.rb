module UserActions::Me
  include UserActions::Callbacks::RefillBorrowerSelect
  include UserActions::Callbacks::CompensationSelect
  include UserActions::Callbacks::Compensation
  include UserActions::Callbacks::RefillBorrower
  include UserActions::Callbacks::Finance
  include UserActions::Callbacks::Statistic

  def me!
    response = Render::Operation::Me.call(current_user: current_user)[:response]
    bot.send_message response.merge(chat_id: current_user.chat_id)
  end
end
