module InfoActions
  module Love
    def love!(*args)
      Info::Response::Love::Success.call(current_user, nil, payload, args)
    end
  end
end