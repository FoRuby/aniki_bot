module Shared::Contract
  class Base < Dry::Validation::Contract
    config.messages.default_locale = :en
    config.messages.namespace = :common
    config.messages.load_paths << 'config/locales/en.yml'

    register_macro(:is_record?) do |macro:|
      klass = macro.args.first
      key.failure("Could not find #{klass} with id = #{value}") if klass.where(id: value).empty?
    end

    register_macro(:future?) do
      key(:date).failure(:past) if value&.to_time&.past?
    rescue ArgumentError
      key(:date).failure(:invalid)
    end
    register_macro(:open_event?) { key.failure(:close) if value.close? }
  end
end