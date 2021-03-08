module Render::Operation
  class UserKickSelect < Trailblazer::Operation
    attr_reader :event, :event_users, :current_user

    step :assign_attributes
    step :event_users?
    fail :failure
    step :response

    def assign_attributes(options, event:, current_user:, **)
      @event = event
      @event_users = event.users
      @current_user = current_user
    end

    def event_users?(options, **)
      event_users.where.not(id: current_user.id).present?
    end

    def response(options, **)
      options[:response] = { text: text, parse_mode: 'html', reply_markup: reply_markup }
    end

    def failure(options, **)
      options[:response] = 'No users to kick out'
    end

    def text
      'Select a User to kick out'
    end

    def reply_markup
      inline_keyboard = event_users.where.not(id: current_user.id).each_with_object([]) do |user, arr|
        arr << [{ text: user.tag, callback_data: "kick:#{user.id}" }]
      end
      { inline_keyboard: inline_keyboard }
    end
  end
end

