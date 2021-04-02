class TelegramController < Telegram::Bot::UpdatesController
  before_action :authenticate_user!

  attr_reader :current_user

  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session
  include CallbackQueryContext
  use_session!

  include InfosController
  include FeedbacksController
  include EventsController
  include UsersController
  include ChangelogController

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
end
