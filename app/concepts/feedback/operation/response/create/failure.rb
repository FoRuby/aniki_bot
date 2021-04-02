module Feedback::Operation::Response::Create
  class Failure < Shared::Operation::Response::Success
    def self.call(...)
      new(...).failure_respond
    end
  end
end
