module Event::Operation
  class Edit < Trailblazer::Operation
    step Model(Event, :find_by)
    step Policy::Pundit(EventPolicy, :edit?)
    step Contract::Build(constant: Event::Contract::Edit, builder: :default_contract!)
    step Contract::Validate()

    def default_contract!(options, constant:, model:, **)
      constant.new(model, event: options[:model])
    end
  end
end

