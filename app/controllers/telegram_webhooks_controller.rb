class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session
  include CallbackQueryContext

  include BaseController
  include InfosController
  include SquadsController
  include EventsController
  include UsersController
  include NotesController

  use_session!

  before_action :authenticate_user!

  def current_user
    @current_user
  end

  def action_missing(action, *_args)
    if action_type == :command
      respond_with :message,
                   text: t('telegram_webhooks.action_missing.command', command: action_options[:command])
    end
  end

  private

  def authenticate_user!
    @current_user = User.find_by_username(from["username"])
    @current_user ||= User::Create.call(user_attributes: from).user
  end
end
