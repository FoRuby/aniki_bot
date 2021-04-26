module Event::Contract
  class Edit < Event::Contract::Base
    validation contract: ::Event::Validation::Edit.new, default: true
  end
end