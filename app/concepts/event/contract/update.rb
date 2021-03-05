module Event::Contract
  class Update < Event::Contract::Base
    property :id
    property :name
    property :date

    validation contract: ::Event::Validation::Update.new
  end
end