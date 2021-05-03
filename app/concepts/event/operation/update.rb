module Event::Operation
  class Update < Trailblazer::Operation
    step Model(Event, :find_by)
    step Policy::Pundit(EventPolicy, :update?)
    step Contract::Build(constant: Event::Contract::Update, builder: :default_contract!)
    step Contract::Validate()
    step Contract::Persist()

    def default_contract!(options, constant:, model:, **)
      constant.new(model, event: model)
    end
  end
end