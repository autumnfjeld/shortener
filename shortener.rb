require 'sinatra'
require 'active_record'
require 'pry'
require 'digest/sha1'

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
  before_save do |record|
    #record.tiny_url = 't'+rand(1000).to_s
    record.tiny_url = (Digest::SHA1.hexdigest record.original_url)[0,10]
  end

  def increment_count
    self.visits += 1
    self.save
  end
end

###########################################################
# Routes
###########################################################

get '/' do
    @links = UrlPair.all # FIXME: should get database info
    erb :index
end

get '/new' do
    erb :form
end

post '/new' do
  puts "params #{params}"
  record = UrlPair.find_or_create_by_original_url(params)
  puts "our record??? #{record.inspect}"
  puts "our json stuff: #{record.tiny_url.to_json}"
  record.tiny_url
end

get '/:tiny' do
  record = UrlPair.find_by_tiny_url(params[:tiny]);
  record.increment_count
  puts params[:tiny]
  puts record.inspect
  redirect to ("http://" + record.original_url)
end


# MORE ROUTES GO HERE