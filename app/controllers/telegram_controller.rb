class TelegramController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session
  include CallbackQueryContext

  before_action :authenticate_user!
  around_action :errors_handler

  attr_reader :current_user

  include InfosController
  include FeedbacksController
  include EventsController
  include UsersController
  include ChangelogController
  include ConfirmationController

  def action_missing(action, *_args)
    return unless action_type == :command

    respond_with(:message, text: t('telegram_webhooks.action_missing.command', command: action_options[:command]))
  end

  private

  def authenticate_user!
    params = User::Parser::Base.call(from)
    @current_user = User::Operation::Update.call(params: params)[:model]
    @current_user ||= User::Operation::Create.call(params: params)[:model]
  end

  # TODO: improve error handling
  def errors_handler
    yield
  rescue Telegram::Bot::Error => e
    reply_with :message, text: e.message
  end
end
