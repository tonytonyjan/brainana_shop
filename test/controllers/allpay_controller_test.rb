require 'test_helper'

class AllpayControllerTest < ActionController::TestCase
  test 'callback' do
    params = {
      RtnCode: '1',
      PaymentType: 'Credit_CreditCard',
      TradeAmt: '700',
      PaymentTypeChargeFee: '14',
      PaymentDate: '2015/02/07 14:21:00',
      SimulatePaid: '0',
      CheckMacValue: '3AF270CCCFA58CA0349F4FD462E21643',
      TradeDate: '2015/02/07 14:20:47',
      MerchantID: '2000132',
      TradeNo: '1502071420478656',
      RtnMsg: '交易成功',
      MerchantTradeNo: '355313'
    }
    post :callback, params
    assert_equal '1|OK', @response.body
    transaction = Transaction.find_by(trade_number: '355313')
    assert_equal params.stringify_keys, transaction.params
  end
end
