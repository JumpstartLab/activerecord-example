require 'active_record'

ENV['DB_ENV'] ||= "development"
database_configuration = YAML::load(File.open('database.yml'))
environment_configuration = database_configuration[ENV['DB_ENV']]

ActiveRecord::Base.establish_connection environment_configuration

class Article < ActiveRecord::Base
  validates :title, uniqueness: true
end

## CREATE

article = Article.new title: "Where are good tacos?",
  body: "Go down the street or fly to San Diego",
  byline: "Taco or Blocko, amirite?"

article.byline = "BYLINE: #{article.byline}"

puts article.inspect
puts article.title
puts article.body
puts article.byline

puts "Result from saving: #{article.save}"
puts "Article after saving: #{article.inspect}"

if article.save
  puts "Article was saved"
else
  puts "article.valid? #{article.valid?}"
  puts "article.invalid? #{article.invalid?}"
  puts "article.errors #{article.errors.to_a}"
  puts "article.errors for title #{article.errors[:title]}"
  puts "article.errors for body #{article.errors[:body]}"
end


puts "-----"

# puts Article.all

### RETRIEVE

found_article = Article.first
puts found_article.inspect


### UPDATE
puts "----\nUpdating\n----"

# Article.update(2,title: "Stop talking about tacos #{Time.now.to_i}")

found_article.title = found_article.title.upcase
found_article.save
puts found_article.inspect

# Updates the attributes and saves all at once.
found_article.update_attributes title: "Please continue talking about tacos", byline: "Taco Lovers Unite!"

### DELETE

# found_article.delete
# found_article.destroy

