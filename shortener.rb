require 'sinatra'
require 'active_record'
require 'pry'

###########################################################
# Configuration
###########################################################


set :public_folder, File.dirname(__FILE__) + '/public'

configure :development, :production do
    ActiveRecord::Base.establish_connection(
       :adapter => 'sqlite3',
       :database =>  'db/dev.sqlite3.db'
     )
end

# Handle potential connection pool timeout issues
after do
    ActiveRecord::Base.connection.close
end

###########################################################
# Models
###########################################################
# Models to Access the database through ActiveRecord.
# Define associations here if need be
# http://guides.rubyonrails.org/association_basics.html

class urlPair < ActiveRecord::Base
end

###########################################################
# Routes
###########################################################

get '/' do
    @links = [] # FIXME
    erb :index
end

get '/new' do
    erb :form
end

post '/new' do
  'created a new Post!'
  #need to access data from post
    # PUT CODE HERE TO CREATE NEW SHORTENED LINKS
end

def teenyurl(u) do
  #compute teenycode
  #add incoming url & teenycode pair to database
  #return teenycode
end

# MORE ROUTES GO HERE