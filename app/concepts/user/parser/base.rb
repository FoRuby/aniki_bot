module User::Parser
  class Base < Shared::ApplicationParser
    def parse
      symbolize_params_keys!
      parse_attributes
      attributes
    end

    def parse_attributes
      attributes.merge!(params.slice(:first_name, :last_name, :username))
      attributes[:chat_id] = params[:id]
    end
  end
end