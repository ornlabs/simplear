require 'active_record'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :first_name
    t.string :last_name
  end
end

ActiveRecord::Schema.define do
  create_table :addresses do |t|
    t.string :street
    t.string :city
    t.string :state
    t.string :zip
  end

  add_reference :addresses, :user
end

class User < ActiveRecord::Base
  has_many :addresses
end

class Address < ActiveRecord::Base
end

puts "\n*** Starting user count: #{User.count}\n\n"

user_one = User.create first_name: 'David', last_name: 'Smith'

puts "\n*** user_one is: #{user_one.inspect}\n\n"

puts "\n*** User count after create: #{User.count}\n\n"

addr_one = Address.create street: '1 Main St', city: 'New York', state: 'NY', zip: '90210'
user_one.addresses << addr_one

puts "\n*** user_user address count: #{user_one.addresses.count}\n\n"

addr_two = Address.create street: '2 Main St', city: 'New York', state: 'NY', zip: '90210'
user_one.addresses << addr_two

puts "\n*** user_user address count: #{user_one.addresses.count}\n\n"

puts "\n*** user_user first address: #{user_one.addresses.first.inspect}\n\n"
