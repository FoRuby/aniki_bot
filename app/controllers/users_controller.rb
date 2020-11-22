module UsersController
  include UserActions::MyEvents
  include UserActions::MyDebtors
  include UserActions::MyFinance
end