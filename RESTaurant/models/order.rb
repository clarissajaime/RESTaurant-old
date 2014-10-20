class Order < ActiveRecord::Base
	belongs_to :party
	belongs_to :food

	def self.total_price(orders)
		total_price = 0
		orders.each do |order|
			total_price += order.food.price
		end
		return total_price
	end

end
