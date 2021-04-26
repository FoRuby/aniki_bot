module Event::Contract
  class Close < Event::Contract::Base
    validation contract: ::Event::Validation::Close.new, default: true
  end
end