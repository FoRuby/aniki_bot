module InfoActions
  module Start
    def start!(*)
      Info::Response::Start::Success.call(current_user, nil, payload)
    end
  end
end