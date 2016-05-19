class Topic < ActiveRecord::Base
  has_and_belongs_to_many :users

  def self.add(topic_array)
    result = Array.new;
    topic_array.each do |t|
      existing = Topic.find_by_topic_name(t)
      if existing
        result << existing
      else
        result << Topic.create(topic_name: t)
      end
    end
    result
  end

  def count
    self.users.count
  end

end
