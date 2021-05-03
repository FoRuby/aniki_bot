module Feedback::Operation
  class Send < Trailblazer::Operation
    step :model!
    step :send_feedback

    def model!(options, model:, **)
      options[:model] = model || options[:feedback]
    end

    def send_feedback(options, model:, current_user:, **)
      text = "From user: #{current_user.tag}\n"
      ANIKI.send_message chat_id: User.find_by(username: 'r1zrei').chat_id, text: text + model.message
    end
  end
end