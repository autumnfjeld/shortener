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

class UrlPair < ActiveRecord::Base
end

###########################################################
# Routes
###########################################################

get '/' do
    @links = [] # FIXME: should get database info
    erb :index
end

get '/new' do
    erb :form
end

post '/new' do
  puts params[:url]
  tinyurl(params[:url])  # params provides data in post request
  #need to access data from post
    # PUT CODE HERE TO CREATE NEW SHORTENED LINKS
end

def tinyurl(origUrl)
  #look in database to see if origUrl is already there
  tinyUrl = 't'+rand(1000).to_s;
  newpair = UrlPair.new ( { original_url: origUrl, tiny_url: tinyUrl})
  if newpair.save
    puts "newpair saved as #{newpair}"
  else
    puts "Failed???"
  end
  tinyUrl
end

# MORE ROUTES GO HERE