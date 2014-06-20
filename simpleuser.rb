require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :first_name
    t.string :last_name
  end
end

class User < ActiveRecord::Base
end

puts "\n*** Starting user count: #{User.count}\n\n"

user_one = User.create first_name: 'David', last_name: 'Smith'

puts "\n*** user_one is: #{user_one.inspect}\n\n"

puts "\n*** User count after create: #{User.count}\n\n"

found_user = User.find 1

puts "\n*** found_user is: #{user_one.inspect}\n\n"

user_one.delete

puts "\n*** User count after delete: #{User.count}\n\n"
