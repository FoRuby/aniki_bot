module InfoActions
  module Roll
    def roll!(*)
      Info::Response::Roll::Success.call(current_user, nil, payload)
    end
  end
end
