module InfoActions
  module Pants
    def pants!(*)
      respond_with :animation, animation: image('pants.mp4')
    end
  end
end