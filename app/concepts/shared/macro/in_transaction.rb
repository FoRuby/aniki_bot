module Shared
  module Macro
    class InTransaction
      def self.call((_ctx, _flow_options), *, &block)
        ActiveRecord::Base.transaction { block.call }
      rescue
        [Trailblazer::Operation::Railway.fail!, [ctx, flow_options]]
      end
    end
  end
end