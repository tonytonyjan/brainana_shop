require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test '自動產生 6 位數交易編號' do
    t = Transaction.new
    assert_match(/\w{6}/, t.trade_number)
  end

  test '避免存入錯誤的交易資訊' do
    t = transactions(:one)
    assert_raise(ActiveRecord::RecordInvalid) do
      t.update! params: {
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
        MerchantTradeNo: '355313xx'
      }
    end
  end
end
