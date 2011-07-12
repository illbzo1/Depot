class Notifier < ActionMailer::Base
  default :from => 'Tyler Moore <tylerlmoore@gmail.com>'

  def order_received(order)
    @order = order

    mail :to => order.email, :subject => 'Pragmatic Store Order Confirmation'
  end

  def order_shipped(order)
    @order = order

     mail :to => order.email, :subject => 'Pragmatic Store Order Shipped'
  end
end
