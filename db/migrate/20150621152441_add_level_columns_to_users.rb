class AddLevelColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :acct_age_level, :integer
    add_column :users, :languages_level, :integer
    add_column :users, :followers_level, :integer
    add_column :users, :repos_level, :integer
    add_column :users, :forks_level, :integer
    add_column :users, :commits_level, :integer
    add_column :users, :stars_level, :integer
  end
end


