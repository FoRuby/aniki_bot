module UserActions::Callbacks::RefillBorrowerSelect
  def refill_borrower_select_callback_query(user_id = nil, *)
    borrowers = current_user.borrowers.where('debt_kopecks > 0')
    borrowers.present? ? render_refill_borrower_select(borrowers) : empty_borrower_select
  end

  def render_refill_borrower_select(...)
    respond_with :message,
                 text: 'Select Borrower:',
                 parse_mode: 'html',
                 reply_markup: select_borrower_reply_markup(...)
  end

  def empty_borrower_select
    answer_callback_query('You have not Borrowers', show_alert: true)
  end

  def select_borrower_reply_markup(borrowers)
    inline_keyboard = borrowers.each_with_object([]) do |user, arr|
      arr << [{ text: user.tag, callback_data: "refill_borrower:#{user.id}" }]
    end
    { inline_keyboard: inline_keyboard }
  end
end

