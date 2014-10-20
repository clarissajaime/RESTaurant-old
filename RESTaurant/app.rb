# This is the main application file that will tell the server what to do.
# It is acting as two components of the application:
# - router
#   - handles the requests to the server
#   - such as: get, post, patch, delete
#   - to urls like: '/', '/users/:id'
# - controller
#   - defines the actions to take
#   - especially getting the correct objects form the model
#   - and rendering the correct view/template (erb files in this case)

## Steps
# Add the require 'bundler' to include the bundle gem
# Add the 'Bundler.require' command, which includes all the libraries specified in the Gemfile
# Don't forget to set up a postgresql database and add the connection to it

require "bundler"
Bundler.require
require 'pry'

ActiveRecord::Base.establish_connection({
  adapter: 'postgresql',
  database: 'restaurant_db'
})

require_relative 'models/food'
require_relative 'models/party'
require_relative 'models/order'


####### HOME PAGE ########
# GET	/	Displays links to navigate the application (including links to each current parties)

get '/' do
  erb :index
end

####### FOOD ROUTES ########

# As an employee who manages the restaurant, I want to manage the menu so that waiting staff can use the app to create orders.

# GET	/foods	Display a list of food items available

get '/foods' do
  @foods = Food.all
  erb :"food/index"
end

# As a user, I want to be able to add new food items, so the menu can change.

get '/foods/new' do
	erb :"food/new"
end


# POST	/foods	Creates a new food item
post '/foods' do
	Food.create(params[:food])
	redirect '/foods'
end

#get /foods/:id	Display a single food item

get '/foods/:id' do
	@food = Food.find(params[:id])
	erb :"food/show"
end

# GET	/foods/:id/edit	Display a form to edit a food item
get '/foods/:id/edit' do
	@food = Food.find(params[:id])
	erb :"food/edit"
end

# PATCH	/foods/:id	Updates a food item
patch '/foods/:id' do
	food = Food.find(params[:id])
	food.update(params[:food])
	redirect '/foods'
end

# DELETE	/foods/:id	Deletes a food item
# delete '/foods/:id' do
# 	Food.delete(params[:id])
# 	redirect '/foods'
# end




####### PARTY ROUTES ########

# As a server, I want to take orders for tables

# GET	/parties	Display a list of all parties
get '/parties' do
  	@parties = Party.all
  	erb :"party/index"
end

# GET	/parties/new	Display a form for a new party
get '/parties/new' do
	erb :"party/new"
end

# POST	/parties	Creates a new party
post '/parties' do
	Party.create(params[:party])
	redirect '/parties'
end

# GET	/parties/:id	Display a single party and options for adding a food item to the party
get '/parties/:id' do
	@party = Party.find(params[:id])
	@orders = @party.orders

	@total_price = 0
	@orders.each do |order|
		@total_price += order.food.price
	end

	erb :"party/show"
end

# GET	/parties/:id/edit	Display a form for to edit a party's details
get '/parties/:id/edit' do
	@party = Party.find(params[:id])
	erb :"party/edit"
end


# PATCH	/parties/:id	Updates a party's details
patch '/parties/:id' do
	party = Party.find(params[:id])
	party.update(params[:party])
	redirect '/parties'
end


# DELETE	/parties/:id	Delete a party
delete '/parties/:id' do
	Party.delete(params[:id])
	redirect '/parties'
end


####### ORDER ROUTES ########

# New order form
get '/parties/:id/orders/new' do
	@party = Party.find(params[:id])
	@foods = Food.where(active: true)
	erb :'order/new'
end

# POST	/orders	Creates a new order
post '/orders' do
	Order.create(params[:order])
	redirect '/parties/' + params[:order][:party_id]
end

# DELETE	/orders	Removes an order
delete '/parties/:party_id/orders/:id' do
	Order.delete(params[:id])
	redirect '/parties/' + params[:party_id]
end

get '/parties/:id/receipt' do
  @party = Party.find(params[:id])
  @orders = @party.orders

  @total_price = 0
  @orders.each do |order|
    @total_price += order.food.price
  end

  file = File.new("./public/receipts/#{@party.id}-receipt.txt", "w")
  file.write(erb :"receipt/template", :layout => false)
  file.close

  send_file file.path, :disposition => 'attachment'


  redirect '/parties/' + params[:id]
end

####### RECIEPT ROUTES ########
# GET	/parties/:id/receipt	Saves the party's receipt data to a file. Displays the content of the receipt. Offer the file for download.
# PATCH	/parties/:id/checkout	Marks the party as paid
