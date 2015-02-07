require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  test '自動產生 6 位數交易編號' do
    t = Transaction.new
    assert_match(/\w{6}/, t.trade_number)
  end
end
