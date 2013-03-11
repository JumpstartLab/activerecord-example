require 'active_record'
require 'yaml'
# require 'logger'

ENV['DB_ENV'] ||= "development"

task :default => :migrate

#
# Uses ActiveRecord's migration functionality to perform a database migration with the specified
# VERSION
#

desc "Migrate the database through scripts in db/migrate. Target specific version with VERSION=x"
task :migrate => :environment do
  puts "Migrating database in the #{ENV['DB_ENV']} environment"

  if ENV["VERSION"]
    ActiveRecord::Migrator.migrate('db/migrate', ENV["VERSION"].to_i)
  else
    # determine the highest level of migration and run that
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

  environment_configuration = database_configuration[ENV['DB_ENV']]

  ActiveRecord::Base.establish_connection environment_configuration

  # #
  # # Log the database operations to a file to make it easier to troublehsoot what is taking place.
  # #
  # ActiveRecord::Base.logger = Logger.new(File.open('database.log', 'a'))
end