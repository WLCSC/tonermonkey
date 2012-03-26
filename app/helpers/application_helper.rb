module ApplicationHelper
def current_user  
    if session[:user_id]
		current_user ||= User.find(session[:user_id])
		if(session[:override])
			@override = true
			current_user.privilege = session[:override]
		else
			@override = false
		end
		current_user
	else
		current_user = nil
		nil
	end
end
def twitterized_type(type)
  case type
    when :alert
      "warning"
    when :error
      "error"
    when :notice
      "info"
    when :success
      "success"
    else
      type.to_s
  end
end

def nice_order order
	"#{order.change} #{link_to order.item.name, order.item}, #{cht(order)}".html_safe
end

def cht order
	case order.change_type
		when 'new'
			"New"
		when 'replace'
			"Replaced"
		when 'rtxfr'
			"Recieved Transfer"
		when 'stxfr'
			"Sent Transfer"
		when 'return'
			"Returned"
		when 'use'
			"Used"
	end
end

def item_tag_field f, n=:tag
	tags = []
	Item.all.each do |i|
		tags << i.name.to_s if i.name != nil
		tags << i.short.to_s if i.short != nil
		tags << i.barcode.to_s if i.barcode != nil
	end
	f.text_field :tag, :"data-provide" => 'typeahead', :"data-items" => tags.length, :"data-source" => tags.to_s, :size => 10
end

end
