module User::Parser
  class Base < Shared::ApplicationParser
    def parse
      symbolize_params_keys!
      attributes.merge(params.slice(:first_name, :last_name, :username), { chat_id: params[:id] })
    end
  end
end