module Event::Operation
  class Close < Trailblazer::Operation
    step :model!
    step Policy::Pundit(EventPolicy, :close?)
    step Contract::Build(constant: Event::Contract::Close, builder: :default_contract!)
    step :prepopulate!
    step Contract::Validate()
    step Contract::Persist()
    step Subprocess(::Event::Operation::CreateDebts)

    def model!(options, params:, **)
      options[:model] = Event.includes(:users).find_by(id: params[:id])
    end

    def prepopulate!(options, **)
      options[:'contract.default'].prepopulate!(status: :close)
    end

    def default_contract!(options, constant:, model:, **)
      constant.new(model, event: model)
    end
  end
end
