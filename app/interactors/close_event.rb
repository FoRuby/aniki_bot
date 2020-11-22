class CloseEvent < BaseInteractor
  include Interactor::Organizer

  organize Event::Find,
           Event::Debt,
           Event::AddDebtToUsers
end