module Event::Operation::Response::Update
  class Failure < Shared::ApplicationResponse
    def self.call(...)
      new(...).failure_respond
    end
  end
end
