module Feedback::Operation
  class Create < Trailblazer::Operation
    step Model(Feedback, :new)
    step Policy::Pundit(FeedbackPolicy, :create?)
    step :assign_current_user!
    step Contract::Build(constant: Feedback::Contract::Create)
    step Contract::Validate()
    step Contract::Persist()
    # step Subprocess(::Feedback::Operation::Send)
    step :send_feedback!

    def assign_current_user!(options, model:, current_user:, **)
      model.user = current_user
    end

    def send_feedback!(options, model:, current_user:, **)
      Feedback::Operation::Send.call(current_user: current_user, feedback: model)
    end
  end
end