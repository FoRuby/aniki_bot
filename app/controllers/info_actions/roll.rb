module InfoActions
  module Roll
    def roll!(*)
      reply_with :animation, animation: image('aniki_roll.mp4'), caption: rand(1..100).to_s
    end
  end
end