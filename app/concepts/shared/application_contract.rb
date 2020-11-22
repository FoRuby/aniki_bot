module Shared
  class ApplicationContract < Dry::Validation::Contract
    config.messages.default_locale = :en
    # config.messages.namespace = :common
    config.messages.load_paths << 'config/locales/en.yml'

    # register_macro(:is_record?) do |macro:|
    #   klass = macro.args.first
    #   if value.is_a? Array
    #     dif = value - klass.where(id: value).pluck(:id)
    #     key.failure("Could not found Permission with id = #{dif}") unless dif.empty?
    #   else
    #     key.failure("Could not find #{klass} with id = #{value}") if klass.where(id: value).empty?
    #   end
    # end
  end
end