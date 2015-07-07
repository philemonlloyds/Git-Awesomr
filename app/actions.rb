#!/usr/bin/env ruby

require 'sinatra'
require 'octokit'

CLIENT_ID = 'ec929278fb87047f1280'
CLIENT_SECRET = '2f6d93489179df343c2fc243d0a1aafd471d556e'

use Rack::Session::Cookie, :secret => rand.to_s()

def current_user
  User.find(session[:user_id]) if session[:user_id]
end

def achievements
  Achievement.all
end

get "/" do
  erb :index
end

def authenticated?
  session[:access_token]
end

def authenticate!
  client = Octokit::Client.new
  url = client.authorize_url CLIENT_ID, :scope => 'user'

  redirect url
end


def account_open
  @days_open = (Date.today - @user.start_date).to_i
  @years_open = @days_open/365.to_f
  achievement_name = @achievement.where(name: "Account Open")
  achievements = achievement_name.select {|a| a.criteria <= @years_open}
  @progress_bar_acc_open = @days_open/1095.to_f*100

  if achievements[0]
    @open_ach_url_1 = achievements[0][:url]
    @total_flags +=1
    @acct_age_level = 1
  end

  if achievements[1]
    @open_ach_url_2 = achievements[1][:url]
    @total_flags +=1
    @acct_age_level = 2
  end

  if achievements[2]
    @open_ach_url_3 = achievements[2][:url]
    @total_flags +=1
     @acct_age_level = 3
  end

end

def language_achieved
  @lang_all=[]
  @user.repos.each do |repo|
    @lang_all << repo.language
    @lang_all.compact!
  end

  @lang_all.uniq!
  achievement_name =[]
  achievement_name = @achievement.where name: "Language"
  achievements = achievement_name.select{|level| level.criteria <=(@lang_all.count) }
  @progress_bar_lang = @lang_all.count/achievement_name[2][:criteria].to_f*100

 if achievements[0]
    @lang_ach_url_1 = achievements[0][:url]if achievements[0]
    @total_flags +=1
    @languages_level = 1
  end

  if achievements[1]
    @lang_ach_url_2 = achievements[1][:url] if achievements[1]
    @total_flags +=1
     @languages_level = 2
  end

  if achievements[2]
    @lang_ach_url_3 = achievements[2][:url] if achievements[2]
    @total_flags +=1
     @languages_level = 3
  end

end

def followers_achieved
  followers = @user.followers
  achievement_name = @achievement.where name: "Followers"
  achievements = []
  achievements = achievement_name.select {|a| a.criteria <= followers}

  if achievements[0]
    @follow_ach_url_1 = achievements[0][:url] if achievements[0]
    @total_flags +=1
    @followers_level = 1
  end

  if achievements[1]
    @follow_ach_url_2 = achievements[1][:url] if achievements[1]
    @total_flags +=1
    @followers_level = 2
  end

  if achievements[2]
    @follow_ach_url_3 = achievements[2][:url] if achievements[2]
    @total_flags +=1
    @followers_level = 3
  end

  followers_criteria = 0
  followers_criteria = achievement_name[2][:criteria]
  @progress_bar_followers = followers/followers_criteria.to_f*100
end

def repositories_achieved
  respositories = @user.public_repos
  achievement_name = @achievement.where name: "Repos"
  achievements = []
  achievements = achievement_name.select {|a| a.criteria <= respositories}

  if achievements[0]
    @repos_ach_url_1 = achievements[0][:url] if achievements[0]
    @total_flags +=1
    @repos_level = 1
  end

  if achievements[1]
    @repos_ach_url_2 = achievements[1][:url] if achievements[1]
    @total_flags +=1
    @repos_level = 2
  end

  if achievements[2]
    @repos_ach_url_3 = achievements[2][:url] if achievements[2]
    @total_flags +=1
    @repos_level = 3
  end

  repos_criteria = 0
  repos_criteria = achievement_name[2][:criteria]
  @progress_bar_repos = respositories/repos_criteria.to_f*100
end


def forks_achieved
 @forks_all = 0
 @user.repos.each do |repo|
 @forks_all += repo.forks_count
 end

achievement_name = @achievement.where name: "Forks"
achievements = []
achievements = achievement_name.select {|a| a.criteria <= @forks_all}

if achievements[0]
  @forks_ach_url_1 = achievements[0][:url] if achievements[0]
  @total_flags +=1
  @forks_level = 1
end

if achievements[1]
  @forks_ach_url_2 = achievements[1][:url] if achievements[1]
   @total_flags +=1
   @forks_level = 2
end

if achievements[2]
  @forks_ach_url_3 = achievements[2][:url] if achievements[2]
  @total_flags +=1
  @forks_level = 3
end

forks_criteria = 0
forks_criteria = achievement_name[2][:criteria]

@progress_bar_forks =@forks_all/forks_criteria.to_f*100
end


def commits_achieved
  days_open = (Date.today - @user.start_date).to_i
  @commits_all = 0
  @user.repos.each do |repo|
  @commits_all += repo.commits_count
  end

  achievement_name = @achievement.where name: "Commits"
  achievements = []
  achievements = achievement_name.select {|a| a.criteria <= @commits_all}

  if achievements[0]
   @commits_ach_url_1 = achievements[0][:url] if achievements[0]
   @total_flags +=1
   @commits_level = 1
  end

  if achievements[1]
    @commits_ach_url_2 = achievements[1][:url] if achievements[1]
    @total_flags +=1
    @commits_level = 2
  end

  if achievements[2]
    @commits_ach_url_3 = achievements[2][:url] if achievements[2]
    @total_flags +=1
    @commits_level = 3
  end

  commits_criteria = 0
  commits_criteria = achievement_name[2][:criteria]

  @progress_bar_commits = @commits_all/commits_criteria.to_f*100
end

def stars_achieved
  @stars_all = 0
  @user.repos.each do |repo|
  @stars_all += repo.stars_count
  end

  achievement_name = @achievement.where name: "Stars"
  achievements = []
  achievements = achievement_name.select {|a| a.criteria <= @stars_all}

  if achievements[0]
    @stars_ach_url_1 = achievements[0][:url] if achievements[0]
    @total_flags +=1
    @stars_level = 1
  end

  if achievements[1]
    @stars_ach_url_2 = achievements[1][:url] if achievements[1]
    @total_flags +=1
    @stars_level = 2
  end

  if achievements[2]
    @stars_ach_url_3 = achievements[2][:url] if achievements[2]
    @total_flags +=1
    @stars_level = 3
  end

  stars_criteria = 0
  stars_criteria = achievement_name[2][:criteria]

  @progress_bar_stars = @stars_all/stars_criteria.to_f*100
end

get '/user/:username' do
  @total_flags = 0
  @acct_age_level = 0
  @languages_level = 0
  @followers_level = 0
  @repos_level = 0
  @forks_level = 0
  @commits_level = 0
  @stars_level = 0
  @user = current_user
  @achievement = achievements
  client = Octokit::Client.new :access_token => session[:access_token]
  data = client.user
  user = User.find_by(username: data.login)
  @user_repos = Octokit.repositories data.login
  account_open
  language_achieved
  followers_achieved
  repositories_achieved
  forks_achieved
  commits_achieved
  stars_achieved
  @user.update flags: @total_flags
  @score = (@total_flags/21.to_f*100).to_i
  @user.update score: @score
  @user.update acct_age_level: @acct_age_level, languages_level: @languages_level, followers_level: @followers_level, repos_level: @repos_level, forks_level: @forks_level, commits_level: @commits_level, stars_level: @stars_level
  erb :'user/index'
end

get 'gitawesomer.herokuapp.com/login' do
  if !authenticated?
    authenticate!
  else
    access_token = session[:access_token]
    scopes = []

    client = Octokit::Client.new \
      :client_id => CLIENT_ID,
      :client_secret => CLIENT_SECRET

    begin
      client.check_application_authorization access_token
    rescue => e
      # request didn't succeed because the token was revoked so we
      # invalidate the token stored in the session and render the
      # index page so that the user can start the OAuth flow again
      session[:access_token] = nil
      return authenticate!
    end

    client = Octokit::Client.new :access_token => access_token
    data = client.user
    user = User.find_by(username: data.login)
    session[:user_id] = user.id
    redirect "/user/#{user.username}"
end
end

get 'gitawesomer.herokuapp.com/callback' do
  session_code = request.env['rack.request.query_hash']['code']
  result = Octokit.exchange_code_for_token(session_code, CLIENT_ID, CLIENT_SECRET)
  session[:access_token] = result[:access_token]

  client = Octokit::Client.new :access_token => session[:access_token]
  data = client.user
  user = User.find_by(username: data.login)
  user_repos = Octokit.repositories data.login
  user_full_name = data.name.split
  total_commits = 0

  unless user then
    user = User.create(
      username: data.login,
      first_name: user_full_name[0],
      last_name: user_full_name[1],
      token: session[:access_token],
      avatar_url: data.avatar_url,
      location: data.location,
      followers: data.followers,
      public_repos: data.public_repos,
      public_gists: data.public_gists,
      start_date: data.created_at
    )

    user_repos.each do |repo|
      commit_activity = Octokit.participation_stats(data.login+"/"+repo.name)
      total_commits += commit_activity[:owner].inject(0){|total,week| total+week} if commit_activity
      user_achievement_info = Repo.create(
      name: repo.name,
      user_id: user.id,
      stars_count: repo.stargazers_count,
      forks_count: repo.forks_count,
      commits_count: total_commits,
      language: repo.language
      )
      total_commits = 0
    end
 end

  session[:user_id] = user.id

  redirect "/user/#{user.username}"
end

get 'gitawesomer.herokuapp.com/logout' do
  session.clear
  redirect '/'
end

get 'gitawesomer.herokuapp.com/user' do
  erb :'user/index'
end

get 'gitawesomer.herokuapp.com/id' do
  @user = current_user
  erb :'/users/id'
end

# get '/group' do
#   erb :'group/new'
# end

# post '/group' do
#   name = params[:name]
#   username = params[:username]

#   group = Group.find_by(name: name)
#     if group
#       redirect '/group/:id'
#     else
#       group = Group.create(name: name)
#       redirect '/group/:id'
#     end
# end

get 'gitawesomer.herokuapp.com/group' do
  # GRAPH DATA
  @user_id = params["id"]
  @user = User.find(@user_id)
  @users_group = User.all


  @achievement = {}
  @achievement[:user] = [@user.acct_age_level, @user.languages_level, @user.followers_level, @user.repos_level, @user.forks_level, @user.commits_level, @user.stars_level]

  group_avg_open = User.all.inject(0) {|total, user| total + user.acct_age_level}/User.count.to_f
  group_avg_lang = User.all.inject(0) {|total, user| total + user.languages_level}/User.count.to_f
  group_avg_followers = User.all.inject(0) {|total, user| total + user.followers_level}/User.count.to_f
  group_avg_repos = User.all.inject(0) {|total, user| total + user.repos_level}/User.count.to_f
  group_avg_forks = User.all.inject(0) {|total, user| total + user.forks_level}/User.count.to_f
  group_avg_commits = User.all.inject(0) {|total, user| total + user.commits_level}/User.all.count.to_f
  group_avg_stars = User.all.inject(0) {|total, user| total + user.stars_level}/User.all.count.to_f

  # binding.pry

  @achievement[:group] = [group_avg_open, group_avg_lang, group_avg_followers, group_avg_repos, group_avg_forks, group_avg_commits, group_avg_stars]
  # @achievement[:group] = [1, 2, 3, 2, 2, 2, 3]

  labels = []
  User.all.each do|user|
  labels << user.username
  end

  @average_score = {}

  user_score = []
  User.all.each do |user|
    user_score << user.score
  end

  average_score_group = []
  User.all.each do |user|
    average_score_group  << average_score = User.all.inject(0) {|total, user| total + user.score}/User.all.count
  end

  @average_score[:user] = user_score
  @average_score[:group] = average_score_group
  @average_score[:user_names] = labels
  erb :'group/index'
end
