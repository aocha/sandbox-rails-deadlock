# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = 100.times.map { |n| User.new(nickname: "nickname-#{n}") }
User.import(users, on_duplicate_key_update: [])

user_ids = User.all.order(id: :asc).pluck(:id)
relationships = user_ids.product(user_ids).map do |follower_id, followee_id|
  Relationship.new(follower_id: follower_id, followee_id: followee_id)
end

relationships.each_slice(1000) do |r|
  Relationship.import(r, on_duplicate_key_update: [])
end
