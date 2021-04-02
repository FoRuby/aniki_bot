module Info::Operation::Response::Roll
  class Success < Shared::Operation::Response::Success
    def success_respond
      bot.send_animation animation: image("aniki_roll#{[1, 2].sample}.mp4"),
                         chat_id: chat_id, reply_to_message_id: message_id, caption: rand(1..100).to_s
    end
  end
end
