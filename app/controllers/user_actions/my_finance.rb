module UserActions::MyFinance
  def my_finance!(*args)
    response = render_debtors + render_debt
    bot.send_message chat_id: current_user.chat_id, text: response
  end

  def render_debtors
    message = UserPayer.where(user: current_user).map { |debtor| "Name: #{debtor.payer.usertag} | Debt: #{debtor.debt.format} \n" }.join
    message.empty? ? "You have no debtors \n" : "Your Debtors: \n" + message
  end

  def render_debt
    message = UserPayer.where(payer: current_user).map { |debtor| "Name: #{debtor.user.usertag} | Debt: #{debtor.debt.format} \n" }.join
    message.empty? ? "You have no debts \n" : "Your Debts: \n" + message
  end
end