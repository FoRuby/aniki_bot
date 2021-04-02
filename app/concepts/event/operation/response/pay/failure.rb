module Event::Operation::Response::Pay
  class Failure < Shared::ApplicationResponse
    def self.call(...)
      new(...).failure_respond
    end
  end
end
