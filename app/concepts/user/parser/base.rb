module User::Parser
  class Base < Shared::ApplicationParser
    def parse
      params.symbolize_keys!
      attributes.merge(params.slice(:first_name, :last_name, :username), { chat_id: params[:id] })
    end
  end
end