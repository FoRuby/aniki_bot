module Shared
  module Macro
    class Transaction
      def self.call((ctx, flow_options), *, &block)
        ActiveRecord::Base.transaction { yield }
      rescue
        [Trailblazer::Operation::Railway.fail!, [ctx, flow_options]]
      end
    end

    class Rollback
      def self.call(*)
        raise ActiveRecord::Rollback
      end
    end
  end
end