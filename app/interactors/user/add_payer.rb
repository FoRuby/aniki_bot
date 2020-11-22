class User::AddPayer < BaseInteractor
  attr_reader :user, :payer, :coefficient, :debt

  before :assign_attributes

  def call
    add_user_payer
  end

  private

  def assign_attributes
    @user = context.user
    @payer = context.payer
    @debt = context.debt
    @coefficient = context.coefficient
  end

  def add_user_payer
    user_payer = user.user_payers.where(user: user, payer: payer).first_or_initialize
    user_payer.debt += debt.abs * coefficient
    user_payer.save
  end
end