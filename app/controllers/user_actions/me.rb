module UserActions::Me
  include UserActions::Callbacks::RefillBorrowerSelect
  include UserActions::Callbacks::CompensationSelect
  include UserActions::Callbacks::Compensation
  include UserActions::Callbacks::RefillBorrower
  include UserActions::Callbacks::Finance
  include UserActions::Callbacks::Statistic

  def me!
    render_me
  end

  def render_me
    bot.send_message chat_id: current_user.chat_id,
                     text: me_header,
                     parse_mode: 'html',
                     reply_markup: me_reply_markup
  end

  def me_header
    'Select option:'
  end

  def me_reply_markup
    {
      inline_keyboard: [
        [{ text: 'Finance', callback_data: "finance:#{current_user.id}" }],
        [{ text: 'Statistic', callback_data: "statistic:#{current_user.id}" }],
        [{ text: 'Refill', callback_data: "refill_borrower_select:#{current_user.id}" }],
        [{ text: 'Compensation', callback_data: "compensation_select:#{current_user.id}" }]
      ]
    }
  end
end