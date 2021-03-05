module UserActions::Callbacks::Statistic
  def statistic_callback_query(user_id = nil, *)
    top_borrower = current_user.top_borrower&.tag || 'N/D'
    top_creditor = current_user.top_creditor&.tag || 'N/D'
    response = "Statistic:\n" +
               "Total spend | #{current_user.total_spend}\n" \
               "Total events | #{current_user.user_events.count}\n" \
               "Total borrowed | #{current_user.total_borrowed}\n" \
               "Top borrower | #{top_borrower}\n" \
               "Total credited | #{current_user.total_credited}\n" \
               "Top creditor | #{top_creditor}"
    bot.send_message chat_id: current_user.chat_id, text: response, parse_mode: 'html'
  end

  # def statistic_callback_query(user_id = nil, *)
    # top_borrower = current_user.top_borrower&.tag || 'N/D'
    # top_creditor = current_user.top_creditor&.tag || 'N/D'
    # response = separator(value: 'Statistic', padstr: ' ', width: 29) +
    #            "<pre>|#{'Total spend'.center(20)}|#{current_user.total_spend.center(8)}|</pre>\n" \
    #            "<pre>|#{'Total events'.center(20)}|#{current_user.user_events.count.to_s.center(8)}|</pre>\n" \
    #            "<pre>|#{'Total borrowed'.center(20)}|#{current_user.total_borrowed.center(8)}|</pre>\n" \
    #            "<pre>|#{'Total credited'.center(20)}|#{current_user.total_credited.center(8)}|</pre>\n" \
               # "<pre>|#{'Top borrower'.center(20)}|#{top_borrower.center(8)}|</pre>\n" \
               # "<pre>|#{'Top creditor'.center(20)}|#{top_creditor.center(8)}|</pre>"
    # bot.send_message chat_id: current_user.chat_id, text: response, parse_mode: 'html'
  # end
end

