module InfoActions
  module Van
    def van!(*)
      Info::Operation::Response::Van::Success.call(current_user, nil, payload)
    end
  end
end