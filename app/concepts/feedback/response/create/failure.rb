module Feedback::Response::Create
  class Failure < Shared::Response::Success
    def self.call(...)
      new(...).failure_respond
    end
  end
end
