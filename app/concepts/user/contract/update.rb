module User::Contract
  class Update < Reform::Form
    property :id
    property :first_name
    property :last_name
    property :username
    property :chat_id

    validation contract: ::User::Validation::Update.new
  end
end