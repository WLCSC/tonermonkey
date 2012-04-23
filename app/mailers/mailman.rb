class Mailman < ActionMailer::Base
  default from: "support@wl.k12.in.us"
  helper :application

  def order_email order, user, recip
	@user = user
	@order = order
	@store = order.store
	@recip = recip
	mail(:to => @recip.email, :subject => "[TonerMonkey] Order ##{order.id}", :from => 'support@wl.k12.in.us')
  end

  def unsafe_email order, item, recip
	@order = order
	@item = item
	@recip = recip
	mail(:to => @recip.email, :subject => "[TonerMonkey] Running Dangerously Low on #{item.name}!", :from => 'support.wl.k12.in.us')
  end
end
