require 'active_record'
require 'yaml'
# require 'logger'

ENV['JET_FUEL_ENV'] ||= "development"

task :default => :migrate

#
# Uses ActiveRecord's migration functionality to perform a database migration with the specified
# VERSION
#

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do
  puts "Migrating My Database in the #{ENV['JET_FUEL_ENV']}"

  if ENV["VERSION"]
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  else
    puts %{
    No database migration VERSION was specified.

    Example Usage:

      rake migrate VERSION=001

    }
  end

end

# Load the database environment and log file, this is a pre-requisite step used by the other steps
task :environment do
  puts "Loading my database environment"
  #
  # Loads up the database connection information in a Hash.
  #
  database_configuration = YAML::load(File.open('database.yml'))

  # test, development, or production
  ENV['DB_ENV'] ||= "development"

  environment_configuration = database_configuration[ENV['DB_ENV']]

  puts environment_configuration

  ActiveRecord::Base.establish_connection environment_configuration

  # #
  # # Log the database operations to a file to make it easier to troublehsoot what is taking place.
  # #
  # ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
end