class Squad::AddUser < BaseInteractor
  attr_reader :squad_name

  before :assign_attributes

  def call
    add_user_to_squad
  end

  private

  def assign_attributes
    context.squad ||= Squad.find_by_name(context.squad_name)
  end

  def add_user_to_squad
    user_squad = UserSquad.new(squad: context.squad, user: context.user)

    fail_interactor!(user_squad.errors) unless user_squad.save
  end
end