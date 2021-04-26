module User::Contract
  class Update < User::Contract::Base
    validation contract: ::User::Validation::Update.new
  end
end