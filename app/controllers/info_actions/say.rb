module InfoActions
  module Say
    def say!(*)
      Info::Operation::Response::Say::Success.call(current_user, nil, payload)
    end
  end
end