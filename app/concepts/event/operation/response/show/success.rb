module Event::Operation::Response::Show
  class Success < Event::Operation::Response::Create::Success
    def success_respond
      respond_msg
    end
  end
end
