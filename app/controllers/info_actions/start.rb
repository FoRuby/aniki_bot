module InfoActions
  module Start
    def start!(*)
      Info::Operation::Response::Start::Success.call(current_user, nil, payload)
    end
  end
end