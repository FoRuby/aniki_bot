module UserActions::Me
  include UserActions::Callbacks::Compensation
  include UserActions::Callbacks::CompensationSelect
  include UserActions::Callbacks::Refill
  include UserActions::Callbacks::RefillSelect
  include UserActions::Callbacks::Finance
  include UserActions::Callbacks::Statistic

  def me!
    User::Response::Me::Success.call(current_user, nil, payload)
  end
end
