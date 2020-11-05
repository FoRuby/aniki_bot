class Squad::DeleteUser < BaseInteractor
  attr_reader :squad, :user, :user_squad
  before :assign_attributes

  def call
    find_user_squad
    delete_user_from_squad
  end

  private

  def assign_attributes
    @squad = Squad.find_by_name(context.squad_name)
    @user = context.user
  end

  def find_user_squad
    @user_squad = UserSquad.find_by(squad: squad, user: user)
  end

  def delete_user_from_squad
    user_squad ? user_squad.destroy : context.fail!
  end
end