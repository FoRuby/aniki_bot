module Event::Operation::Response::Leave
  class Failure < Shared::ApplicationResponse
    def self.call(...)
      new(...).failure_respond(callback: true)
    end
  end
end
