get '/' do
  erb :index
end

post '/find' do
  redirect "/#{params[:username]}"
end

post '/gettweets' do
   if TwitterUser.find_by_username(params["username"])
    @user = TwitterUser.find_by_username(params["username"])
    if @user.tweets_stale?
      timeline = @user.fetch_tweets!
      timeline.each do |tweet|
        @user.tweets << Tweet.find_or_create_by(:body => tweet.text)
      end
    end
  else
    @user = TwitterUser.create(:username => params["username"])
    timeline = @user.fetch_tweets!
    timeline.each do |tweet|
      @user.tweets << Tweet.find_or_create_by(:body => tweet.text)
    end
  end

  erb :index, layout: false
end
