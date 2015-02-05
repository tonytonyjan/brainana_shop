module Allpay
  module_function
  def client
    @client ||= Allpay::Client.new merchant_id: Settings.allpay.merchant_id,
      hash_key: Settings.allpay.hash_key,
      hash_iv: Settings.allpay.hash_iv,
      mode: Settings.allpay.mode
  end
end