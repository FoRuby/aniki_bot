module Event::Operation
  # Event::Operation::Create.call(current_user: current_user, params: { name: name, date: date })
  class Create < Trailblazer::Operation
    step Model(Event, :new)
    step Policy::Pundit(EventPolicy, :create?)
    step Contract::Build(constant: Event::Contract::Create)
    step :prepopulate!
    step Contract::Validate()
    step Contract::Persist()
    step :assign_admin_role!

    def prepopulate!(options, current_user:, **)
      options['contract.default'].prepopulate!(status: :open, user_events: [{ user_id: current_user.id }])
    end

    def assign_admin_role!(options, model:, current_user:, **)
      current_user.add_role :admin, model
    end
  end
end