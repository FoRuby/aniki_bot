class CreateNote < BaseInteractor
  include Interactor::Organizer

  organize Note::Create
end