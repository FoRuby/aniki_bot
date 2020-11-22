class EventPayment < BaseInteractor
  include Interactor::Organizer

  organize Event::Find,
           Event::Payment
end