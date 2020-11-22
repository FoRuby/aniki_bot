class TelegramWebhooksController < Telegram::Bot::UpdatesController
  before_action :authenticate_user!

  attr_reader :current_user

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

  def action_missing(action, *_args)
    if action_type == :command
      respond_with :message,
                   text: t('telegram_webhooks.action_missing.command', command: action_options[:command])
    end
  end

  private

  def authenticate_user!
    params = User::Parser::Base.call(from)
    @current_user = User::Operation::Update.call(params: params)[:'contract.update_user']&.model
    @current_user ||= User::Operation::Create.call(params: params)[:'contract.create_user'].model
  end
end
