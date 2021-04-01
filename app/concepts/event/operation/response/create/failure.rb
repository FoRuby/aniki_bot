module Event::Operation::Response::Create
  class Failure < Shared::ApplicationResponse
    def self.call(...)
      new(...).failure_respond
    end
  end
end
