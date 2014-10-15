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
require_relative 'models/party'
require_relative 'models/order'


####### HOME PAGE ########
#GET	/	Displays links to navigate the application (including links to each current parties)

get '/' do
  erb :index
end

####### FOOD ROUTES ########

# As an employee who manages the restaurant, I want to manage the menu so that waiting staff can use the app to create orders. 

#GET	/foods	Display a list of food items available
# INDEX: As a user, I want to see all of the food items
# Add the route for a get request at /foods
# Get all of the foods and assign that object to an instance variable
# so it can be used in the view
# Render the posts index template

get '/foods' do
  @food = Food.all
  erb :"food/index"
end

# NEW: As a user, I want to be able to add new food items, so the menu can change. 

# GET	/foods/new	Display a form for a new food item
# Add the route for a get request at /foods/new
# Render the foods new template
post '/foods/new' do
	@food = REPLACE
	erb: "Food/new"

# ??? POST	/foods	Creates a new food item ???



#EDIT: As a user, I want to be able to edit the food items, so that we can update the descriptions. 

# GET	/foods/:id/edit	Display a form to edit a food item


# ??? PATCH	/foods/:id	Updates a food item ???




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