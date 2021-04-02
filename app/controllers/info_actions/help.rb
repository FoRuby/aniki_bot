module InfoActions
  module Help
    def help!(*)
      Info::Operation::Response::Start::Success.call(current_user, nil, payload)
    end
  end
end