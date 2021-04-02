module InfoActions
  module Aniki
    def aniki!(*)
      Info::Operation::Response::Aniki::Success.call(current_user, nil, payload)
    end
  end
end