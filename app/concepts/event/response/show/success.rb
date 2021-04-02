module Event::Response::Show
  class Success < Event::Response::Create::Success
    def success_respond
      respond_msg
    end
  end
end
