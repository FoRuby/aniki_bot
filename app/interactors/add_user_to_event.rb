class AddUserToEvent < BaseInteractor
  include Interactor::Organizer

  organize Event::Find,
           Event::AddUser
end