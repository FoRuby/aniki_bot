module Event::Operation::Response::KickSelect
  class Failure < Shared::ApplicationResponse
    def self.call(...)
      new(...).failure_respond(callback: true)
    end
  end
end
