class DeleteUserFromEvent < BaseInteractor
  include Interactor::Organizer

  organize Event::Find,
           Event::DeleteUser
end