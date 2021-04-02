module Feedback::Operation
  class Create < Trailblazer::Operation
    step Model(Feedback, :new)
    step Policy::Pundit(FeedbackPolicy, :create?)
    step Contract::Build(constant: Feedback::Contract::Create)
    step :prepopulate
    step Contract::Validate()
    step Contract::Persist()
    step :send_feedback

    def prepopulate(options, current_user:, **)
      options[:'contract.default'].prepopulate!(user_id: current_user.id)
    end

    def send_feedback(options, model:, current_user:, **)
      Feedback::Operation::Send.call(current_user: current_user, feedback: model)
    end
  end
end