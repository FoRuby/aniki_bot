module InfoActions
  module Say
    def say!(*)
      Info::Response::Say::Success.call(current_user, nil, payload)
    end
  end
end