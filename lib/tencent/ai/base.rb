require 'digest'
require 'json'
require 'rest-client'

module Tencent
  module Ai
    class Base
      END_POINT = 'https://api.ai.qq.com/fcgi-bin/'.freeze

      attr_accessor :app_id, :app_key

      def initialize(app_id, app_key)
        self.app_id  = app_id
        self.app_key = app_key
      end

      def request_payload(data)
        params        = {
          app_id:     app_id,
          time_stamp: Time.now.to_i.to_s,
          nonce_str:  rand(999999).to_s
        }.merge data
        params[:sign] = self.class.sign(params, app_key)
        params
      end

      def post(path, payload)
        res = RestClient.post(uri(path), payload)
        JSON.parse(res.body, object_class: OpenStruct).data
      end

      def uri(path)
        "#{END_POINT}#{path}"
      end

      def self.sign(params, app_key)
        params = Hash[params.sort]
        str    = URI.encode_www_form(params)
        str    = "#{str}&app_key=#{app_key}"
        (Digest::MD5.hexdigest str).upcase
      end
    end
  end
end