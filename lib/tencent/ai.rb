require 'tencent/ai/version'
require 'tencent/ai/base'
require 'tencent/ai/nlp'

module Tencent
  module Ai
    class << self

      attr_accessor :app_id, :app_key

      def configure
        yield(self) if block_given?
      end

      def nlp
        @nlp ||= Nlp.with(app_id, app_key)
      end

    end
  end
end
