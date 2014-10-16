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

ActiveRecord::Base.establish_connection({
  adapter: 'postgresql',
  database: 'restaurant_db'
})

require_relative 'models/food'
# require_relative 'models/party'
# require_relative 'models/order'


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

# ??? PATCH	/foods/:id	Updates a food item ???
patch '/foods/:id' do
	food = Food.find(params[:id])
	food.update(params[:food])
	redirect '/foods'
end 



#DELETE: As a user, I want to be able to delete food items so that I can get rid of unpopular items. 

# DELETE	/foods/:id	Deletes a food item




####### PARTY ROUTES ########

# As a server, I want to take orders for tables

# GET	/parties	Display a list of all parties
get '/parties' do
  @party = Party.all
  erb :"party/index"
end


# As a server, I want to select the table that I am taking an order from.

# GET	/parties/new	Display a form for a new party

# POST	/parties	Creates a new party

# GET	/parties/:id	Display a single party and options for adding a food item to the party



### ??
# GET	/parties/:id/edit	Display a form for to edit a party's details
# PATCH	/parties/:id	Updates a party's details
# DELETE	/parties/:id	Delete a party ??


####### ORDER ROUTES ########


# POST	/orders	Creates a new order
# DELETE	/orders	Removes an order
# GET	/parties/:id/receipt	Saves the party's receipt data to a file. Displays the content of the receipt. Offer the file for download.
# PATCH	/parties/:id/checkout	Marks the party as paid