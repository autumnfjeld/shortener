# Put your database migration here!
#
# Each one needs to be named correctly:
# timestamp_[action]_[class]
#
# and once a migration is run, a new one must
# be created with a later timestamp.

class CreateLinks < ActiveRecord::Migration
    # PUT MIGRATION CODE HERE TO SETUP DATABASE
    # Note : crazy rules about 
    def change
      create_table :url_pairs do |t|
        t.string :original_url
        t.string :tiny_url

        t.timestamps
      end
    end
    # def self.up
    # end

    # def self.down
    # end
end