module Event::Contract
  class Base < Reform::Form
    property :id
    property :name
    property :date, format: :date
    property :status, default: :open, prepopulator: ->(options) { self.status = options[:status] || :open }
    property :description

    property :date_string, virtual: true
    property :event, virtual: true
  end
end