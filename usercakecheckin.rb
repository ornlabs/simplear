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
  create_table :cakes do |t|
    t.string :name
  end
end

ActiveRecord::Schema.define do
  create_table :checkins do |t|
    t.integer :user_id
    t.integer :cake_id
    t.string :description
    t.integer :rating
    t.timestamps
  end
end

class User < ActiveRecord::Base
  has_many :checkins
  has_many :cakes, :through => :checkins
end

class Cake < ActiveRecord::Base
  has_many :checkins
  has_many :users, :through => :checkins
end

class Checkin < ActiveRecord::Base
  belongs_to :user
  belongs_to :cake
end

user_one = User.create first_name: 'David', last_name: 'Smith'

cake_one = Cake.create name: 'Best cake'
cake_two = Cake.create name: 'OK cake'
cake_three = Cake.create name: 'Bad cake'

user_one_checkin = Checkin.create user: user_one, cake: cake_two, description: 'Greate cake', rating: 5

puts "User checkins: #{user_one.checkins.inspect}"
