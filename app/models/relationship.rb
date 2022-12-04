class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  def self.bulk_insert(number_of_threads:)
    followee_ids = User.all.order(id: :asc).pluck(:id).take(5)
    threads = [*1..100].take(number_of_threads).map do |follower_id|
      Thread.new do
        ApplicationRecord.transaction do
          relationships = followee_ids.map do |followee_id|
            Relationship.new(follower_id: follower_id, followee_id: followee_id, count: Random.rand(0..100))
          end
          relationships.each_slice(100) do |r|
            Relationship.import(r, on_duplicate_key_update: [:count])
          end
        end
      end
    end
    threads.each(&:join)
    puts 'completed'
  end
end
