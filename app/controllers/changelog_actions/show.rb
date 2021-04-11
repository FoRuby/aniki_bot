module ChangelogActions
  module Show
    def changelog!(*args)
      Changelog::Response::Show::Success.call(current_user, nil, payload, args)
    end
  end
end
