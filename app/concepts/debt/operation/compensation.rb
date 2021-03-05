module Debt::Operation
  class Compensation < Trailblazer::Operation
    step :debt1
    step :debt2
    step :opponent
    step :update_debt1
    step :consent?
    # fail :notificate_opponent
    step :compensate
    step :refill_debts
    step :close_compensation
    # step :notificate_users

    def debt1(options, current_user:, params:, **)
      options[:debt1] = Debt.find_by(creditor_id: current_user.id, borrower_id: params[:opponent_id])
    end

    def debt2(options, current_user:, params:, **)
      options[:debt2] = Debt.find_by(creditor_id: params[:opponent_id], borrower_id: current_user.id)
    end

    def opponent(options, params:, **)
      options[:opponent] = User.find_by(id: params[:opponent_id])
    end

    def update_debt1(options, **)
      options[:debt1].update(is_compensation: true)
    end

    def consent?(options, **)
      options[:debt2].is_compensation
    end

    def compensate(options, current_user:, **)
      options[:compensation] = [options[:debt1].debt, options[:debt2].debt].min
    end

    def refill_debts(options, current_user:, **)
      true if options[:compensation] == Money.new(0, 'RUB')

      Refill::Operation::Create.call(
        current_user: current_user,
        params: { from_user: current_user, to_user: options[:opponent], value: options[:compensation] }
      )
      Refill::Operation::Create.call(
        current_user: current_user,
        params: { from_user: options[:opponent], to_user: current_user, value: options[:compensation] }
      )
    end

    def close_compensation(options, current_user:, **)
      [options[:debt1], options[:debt2]].each { |debt| debt.update(is_compensation: false) }
    end

    # def notificate_users(options, current_user:, **)
      # message =
      #   "Compensation between #{current_user.tag} and #{options[:opponent].tag} complete. Compensation sum = #{compensation.format}"
      # ANIKI.send_message chat_id: current_user.chat_id, text: message
      # ANIKI.send_message chat_id: options[:opponent].chat_id, text: message
    # end

    # def notificate_opponent(options, **)
      # message =
      #   "#{current_user.tag} trying to compensate a debt. Select /me => Compensation => #{options[:opponent].tag} to complete action"
      # ANIKI.send_message chat_id: options[:opponent].chat_id, text: message
    # end
  end
end