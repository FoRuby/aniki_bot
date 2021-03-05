module UserActions::Callbacks::Finance
  def finance_callback_query(user_id = nil, *)
    response = render_borrowers + render_creditors
    bot.send_message chat_id: current_user.chat_id, text: response, parse_mode: 'html'
  end

  def render_borrowers
    message = current_user.user_borrowers.map do |debt|
      "#{debt.borrower.tag} | #{debt.debt.format}\n"
    end.join
    return "You have not Borrowers\n" if message.empty?

    "Your Borrowers:\n" + message
  end

  def render_creditors
    message = current_user.user_creditors.map do |debt|
      "#{debt.creditor.tag} | #{debt.debt.format}\n"
    end.join
    return "You have not Creditors\n" if message.empty?

    "Your Creditors:\n" + message
  end

  # Table view
  # def render_borrowers
  #   message = current_user.user_borrowers.map do |debt|
  #     "|#{debt.borrower.tag.center(20)}|#{debt.debt.format.center(8)}|"
  #   end.join("\n")
  #   return separator(value: 'Your have not Borrowers', padstr: ' ', width: 29) if message.empty?
  #
  #   separator(value: 'Your Borrowers', width: 29) +
  #     "<pre>|#{'Name'.center(20)}|#{'Borrow'.center(8)}|</pre>\n" \
  #     "<pre>#{message}</pre>\n"
  # end
  #
  # def render_creditors
  #   message = current_user.user_creditors.map do |debt|
  #     "|#{debt.creditor.tag.center(20)}|#{debt.debt.format.center(8)}| "
  #   end.join("\n")
  #   return separator(value: 'You have not Creditors', padstr: ' ', width: 29) if message.empty?
  #
  #   separator(value: 'Your Creditors', width: 29) +
  #     "<pre>|#{'Name'.center(20)}|#{'Credit'.center(8)}|</pre>\n" \
  #     "<pre>#{message}</pre>\n"
  # end
end

