module Event::Contract
  class Update < Event::Contract::Base
    validation contract: ::Event::Validation::Update.new
  end
end