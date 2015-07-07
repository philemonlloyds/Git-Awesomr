require 'github_api'
require 'pry'
require 'ghee'
require "octokit"
require 'date'

name = 'torvalds'
# GET /users/:username/repos
user_repos = Octokit.repositories name
# total_commits = 0

user_repos.each do |i|
  commit_activity = Octokit.participation_stats(name+"/"+user_repos[1].name)
  total_commits += commit_activity[:owner].inject(0){|total,week| total+week}
end

# puts "Number of commits for all repos in the last year for #{name} = #{total_commits}"

# # puts "average number of commits per repo #{total_commits/}"

stargazers_count = 0
forks_count_count = 0
recent_repos =[]
user_languages =[]
user_unique_languages =[]

user_repos.each do |i|
  stargazers_count += i[:stargazers_count]
end

user_repos.each do |i|
  forks_count_count += i [:forks_count]
end

user_repos.each do |i|
  recent_repos << i[:name] if (i[:updated_at].to_date > (Date.today - 50))
end



user_repos.each do |i|
  user_languages << i [:language] if i [:language]
end


puts "Number of stars for #{name} = #{stargazers_count}"
puts "Number of forks for #{name} = #{forks_count_count}"

puts "Number of langauages for user #{user_languages.uniq.count}"

user_unique_languages = user_languages.uniq

user_unique_languages .each do |i|
  puts "Languages used by #{name} ==== #{i}"
end


recent_repos.each do |i|
  puts "Popular repos for #{name} #{i}"
end









#languages 
# user_languages = Octokit.languages (name+"/"+user_repos[1].name)

# user_repos.each do |i|
# user_languages_with_bytes = Octokit.languages (name+"/"+ i.name)
# user_languages << user_languages_with_bytes
# end


  # stargazers_count = 0
  # forks_count_count = 0
  # total_commits = 0
  # recent_repos = []
  # user_languages = []
  # user_unique_languages = []

  # user_repos.each do |i|
  #   commit_activity = Octokit.participation_stats(data.login+"/"+user_repos[1].name)
  #   total_commits += commit_activity[:owner].inject(0){|total,week| total+week}
  # end

  # user_repos.each do |i|
  #   stargazers_count += i[:stargazers_count]
  # end

  # user_repos.each do |i|
  #   forks_count_count += i [:forks_count]
  # end

  # user_repos.each do |i|
  #   recent_repos << i[:name] if (i[:updated_at].to_date > (Date.today - 50))
  # end

  # user_repos.each do |i|
  # user_languages << i [:language] if i [:language]
  # end

  # user_unique_languages = user_languages.uniq

  # user_achievement_info = Repo.create(
  #   name: data.login,
  #   stars_count: stargazers_count,
  #   forks_count: forks_count_count,
  #   commits_count: total_commits,
  #   language: user_unique_languages
  #   )

  # end

<!--     <% @languages.each do |lang| %>
      <%= lang %>
    <% end %> -->


