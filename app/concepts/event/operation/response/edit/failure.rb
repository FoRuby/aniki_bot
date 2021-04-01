module Event::Operation::Response::Edit
  class Failure < Event::Operation::Response::Create::Failure
    def self.call(...)
      new(...).failure_respond(callback: true)
    end
  end
end
