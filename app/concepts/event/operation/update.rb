module Event::Operation
  class Update < Trailblazer::Operation
    step Model(Event, :find_by)
    step Policy::Pundit(EventPolicy, :update?)
    step :add_params!
    step Contract::Build(constant: Event::Contract::Update, builder: :default_contract!)
    step Contract::Validate()
    step Contract::Persist()

    def add_params!(options, params:, **)
      params[:date_string] = params[:date] if params[:date]
      true
    end

    def default_contract!(options, constant:, model:, **)
      constant.new(model, event: model)
    end
  end
end