module UserActions::Me
  include UserActions::Callbacks::RefillBorrowerSelect
  include UserActions::Callbacks::CompensationSelect
  include UserActions::Callbacks::Compensation
  include UserActions::Callbacks::RefillBorrower
  include UserActions::Callbacks::Finance
  include UserActions::Callbacks::Statistic

  def me!
    User::Operation::Response::Me::Success.call(current_user, nil, payload)
  end
end
