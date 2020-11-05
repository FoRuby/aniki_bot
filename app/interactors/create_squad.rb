class CreateSquad < BaseInteractor
  include Interactor::Organizer

  organize Squad::Create,
           Squad::AddUser
end