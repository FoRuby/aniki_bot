module UserActions::Callbacks::CompensationSelect
  def compensation_select_callback_query(user_id = nil, *)
    compensation_users = current_user.borrowers & current_user.creditors
    compensation_users.present? ? render_compensation_select(compensation_users) : empty_compensation_select
  end

  def render_compensation_select(...)
    respond_with :message,
                 text: 'Select user for Compensation:',
                 parse_mode: 'html',
                 reply_markup: compensation_select_reply_markup(...)
  end

  def empty_compensation_select
    answer_callback_query('You have not users to compensate', show_alert: true)
  end

  def compensation_select_reply_markup(compensation_users)
    inline_keyboard = compensation_users.each_with_object([]) do |user, arr|
      arr << [{ text: user.tag, callback_data: "compensation:#{user.id}" }]
    end
    { inline_keyboard: inline_keyboard }
  end
end

