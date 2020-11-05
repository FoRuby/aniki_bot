module UsersController
  include UserActions::MyEvents
  include UserActions::MyDebtors
end