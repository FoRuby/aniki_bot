module Info::Response::Aniki2
  class Success < Shared::Response::Success
    def success_respond
      (1..4).each do |i|
        bot.send_sticker sticker: image("aniki#{i}.webp"), chat_id: chat_id
      end
    end
  end
end
