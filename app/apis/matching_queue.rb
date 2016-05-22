require 'singleton'

class MatchingQueue
  include Singleton
  include SharedHelpers
  def initialize
    @matching_queue = []
    @force_matching_queue = []
    @pusher = pusher
  end

  def add(user)
    @matching_queue << user
  end

  def match(user)
    max = 0;
    result_user = nil;
    result_index = nil;
    index = 0;
    unless @matching_queue.empty?
      @matching_queue.each do |u|
        my_topics = user.topics.map{|t| t.id}
        your_topics = u.topics.map{|t| t.id}
        intersection_score = (my_topics & your_topics).length
        if(max < intersection_score)
          result_user = u
          result_index = index
        end
        index = index + 1
      end

      if result_user
        @matching_queue.delete_at(result_index)
        new_channel = Digest::MD5.hexdigest(SecureRandom.uuid.to_s)

        pusher.trigger(user.session.token, 'matched',{channel_name: new_channel})
        pusher.trigger(result_user.session.token, 'matched',{channel_name: new_channel})
      else
        self.add(user)
        return false
      end
    else
      self.add(user)
      return false
    end
  end

end