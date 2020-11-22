class Squad::Create < BaseInteractor
  attr_reader :squad_attributes, :squad

  before :assign_attributes

  def call
    create_squad
    set_up_squad
  end

  private

  def assign_attributes
    @squad_attributes = {}
    @squad_attributes[:name] = context.squad_attributes.first
  end

  def create_squad
    @squad = Squad.new(squad_attributes)

    squad.save ? set_up_squad : fail_interactor!(squad.errors)
  end

  def set_up_squad
    context.squad = squad
  end
end