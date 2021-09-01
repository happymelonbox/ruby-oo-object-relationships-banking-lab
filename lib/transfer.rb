require 'pry'
class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  @@history = []
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid? ? true : false
  end

  def execute_transaction
    if @sender.balance > @amount && self.valid? && @status == "pending"
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = "complete"
      @@history << self
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    @@history.last.receiver.balance -= @@history.last.amount
    @@history.last.sender.balance += @@history.last.amount
    @@history.last.status = "reversed"
  end

end
