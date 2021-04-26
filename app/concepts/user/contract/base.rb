module User::Contract
  class Base < Reform::Form
    property :id
    property :first_name
    property :last_name
    property :username
    property :chat_id
  end
end