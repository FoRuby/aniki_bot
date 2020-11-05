class CreateEvent < BaseInteractor
  include Interactor::Organizer

  organize Event::Create,
           Event::AddUser,
           Event::SetAdmin
end