class EventBank < BaseInteractor
  include Interactor::Organizer

  organize Event::Find,
           Event::Bank
end