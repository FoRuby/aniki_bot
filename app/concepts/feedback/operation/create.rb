module Feedback::Operation
  class Create < Trailblazer::Operation
    step Model(Feedback, :new)
    step Policy::Pundit(FeedbackPolicy, :create?)
    step Contract::Build(constant: Feedback::Contract::Create)
    step :prepopulate
    step Contract::Validate()
    step Contract::Persist()
    step :send

    def prepopulate(options, current_user:, **)
      options[:'contract.default'].prepopulate!(user_id: current_user.id)
    end

    def send(options, model:, current_user:, **)
      text = "From user: #{current_user.tag}\n"
      ANIKI.send_message chat_id: User.find_by(username: 'r1zrei').chat_id, text: text + model.message
    end
  end
end