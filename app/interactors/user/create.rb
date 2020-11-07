class User::Create < BaseInteractor
  attr_reader :user_attributes, :user

  before :assign_attributes

  def call
    create_user
    set_up_user
  end

  private

  def assign_attributes
    attr = context.user_attributes.symbolize_keys
    @user_attributes = attr.slice(:first_name, :last_name, :username)
    @user_attributes[:chat_id] = attr[:id].to_i
  end

  def create_user
    @user = User.find_by_username(user_attributes[:username])
    @user = User.create(user_attributes) unless user
  end

  def set_up_user
    context.user = user
  end
end
