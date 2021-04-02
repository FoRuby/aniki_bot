module InfoActions
  module Aniki2
    def aniki2!(*)
      Info::Response::Aniki2::Success.call(current_user, nil, payload)
    end
  end
end