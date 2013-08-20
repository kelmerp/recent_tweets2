class TwitterUser < ActiveRecord::Base
  has_many :tweets

  def tweets_stale?
    timeDiff = (self.tweets.first.created_at - self.tweets.last.created_at)/60/10
    ((Time.now - self.tweets.last.created_at)/60) > timeDiff
  end

  def fetch_tweets!
    CLIENT.user_timeline(self.username, count: 10)
  end
end
