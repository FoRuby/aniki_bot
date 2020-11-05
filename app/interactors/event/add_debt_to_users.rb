class Event::AddDebtToUsers < BaseInteractor
  attr_reader :event, :user_events, :majors, :minors

  before :assign_attributes

  def call
    add_debt_to_user
  end

  private

  def assign_attributes
    @event = context.event
    @user_events = event.user_events
    @majors = user_events.major
    @minors = user_events.minor
  end

  def add_debt_to_user
    majors.each do |major|
      coefficient = major.debt / major_bank
      minors.each do |minor|
        User::AddPayer.call(user: major.user, payer: minor.user, coefficient: coefficient, debt: minor.debt)
      end
    end
  end

  def major_bank
    @major_bank ||= majors.map(&:debt).sum
  end
end