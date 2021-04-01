module Event::Operation::Response::Bank
  class Failure < Shared::ApplicationResponse
    def self.call(...)
      new(...).failure_respond(callback: true)
    end
  end
end
