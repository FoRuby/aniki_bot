module UserActions::MyDebtors
  # def my_debtors!(*args)
  #   debtors = current_user.user_payers.includes(:payer)
  #   if debtors.any?
  #     message = "Your Debtors: \n" + render_debtors(debtors)
  #     reply_with :message, text: t('.success', message: message)
  #   else
  #     reply_with :message, text: t('.failure')
  #   end
  # end
  #
  # def render_debtors(debtors)
  #   debtors.map { |debtor| "Name: #{debtor.payer.usertag} | Debt: #{debtor.debt.format} \n" }.join
  # end
end