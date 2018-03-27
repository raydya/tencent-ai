RSpec.describe Tencent::Ai do
  before(:all) do
    Tencent::Ai.configure do |config|
      # config.app_id  = 'this is an app id'
      # config.app_key = 'this is an app key'
      config.app_id  = '1106728343'
      config.app_key = 'n2dlYzVYUspTYEQA'
    end
  end

  it "has a version number" do
    expect(Tencent::Ai::VERSION).not_to be nil
  end

  it "sign" do
    params  = {
      app_id:     'an app key',
      time_stamp: '1522120339',
      nonce_str:  '1522120339',
      data:       'something what to request'
    }
    app_key = 'this is an app key'
    signed  = Tencent::Ai::Base.sign(params, app_key)
    expect(signed).to eq('9EFAFEC7D5CEC77F1BAA149D8EB4B437')
  end

  it "seg 自然语言处理" do
    res        = Tencent::Ai.nlp.seg('南京市长江大桥')
    base_words = res.base_tokens.collect(&:word)
    mix_words  = res.mix_tokens.collect(&:word)
    expect(base_words).to eq(["\xE5\x8D", "\x97\xE4", "\xBA\xAC", "\xE5\xB8", "\x82\xE9", "\x95\xBF", "\xE6\xB1", "\x9F\xE5", "\xA4\xA7", "\xE6\xA1", "\xA5"])
    expect(mix_words).to eq(["\xE5\x8D", "\x97\xE4", "\xBA\xAC", "\xE5\xB8", "\x82\xE9", "\x95\xBF", "\xE6\xB1", "\x9F\xE5", "\xA4\xA7", "\xE6\xA1", "\xA5"])
  end

  it "get sign" do
    params = { :app_id     => "1106728343",
               :time_stamp => "1522134039",
               :nonce_str  => "9247",
               :text       => "南京市长江大桥"
    }
    signed = Tencent::Ai::Base.sign(params, Tencent::Ai.app_key)
    puts signed.inspect
  end
end
