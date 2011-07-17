class Notifier < ActionMailer::Base
  default :from => 'Tyler Moore <tyleronrails@gmail.com>'

  def order_received(order)
    @order = order

    mail :to => order.email, :subject => 'Pragmatic Store Order Confirmation'
  end

  def order_shipped(order)
    @order = order

     mail :to => order.email, :subject => 'Pragmatic Store Order Shipped'
  end
  
  def error_occured(error)
    @error = error
    mail :to => "tylerlmoore@gmail.com", :subject => 'Depot App Error Report'
  end
end
