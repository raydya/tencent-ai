module Tencent
  module Ai
    class Nlp < Base
      SEG_WORD = '/nlp/nlp_wordseg'.freeze

      def self.with(app_id, app_key)
        new(app_id, app_key)
      end

      def seg(word)
        payload = request_payload({ text: word })
        post(SEG_WORD, payload)
      end
    end
  end
end