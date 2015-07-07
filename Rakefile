require 'rake'
require "sinatra/activerecord/rake"
require ::File.expand_path('../config/environment', __FILE__)

Rake::Task["db:create"].clear
Rake::Task["db:drop"].clear

# NOTE: Assumes SQLite3 DB
desc "create the database"
task "db:create" do
  touch 'sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'sqlite3'
end

desc "populate the achievements table"
task "db:populate" do
  Achievement.destroy_all
  Achievement.create(name: "Account Open", level: 1 , url: "/images/outline_open.png", criteria: 0)
  Achievement.create(name: "Account Open", level: 2 , url: "/images/solid_open.png", criteria: 1)
  Achievement.create(name: "Account Open", level: 3 , url: "/images/flat_open.png", criteria: 3)
  Achievement.create(name: "Language", level: 1 , url: "/images/outline_languages.png", criteria: 2)
  Achievement.create(name: "Language", level: 2 , url: "/images/solid_languages.png", criteria: 4)
  Achievement.create(name: "Language", level: 3 , url: "/images/flat_languages.png", criteria: 5)
  Achievement.create(name: "Followers", level: 1 , url: "/images/outline_earth.png", criteria: 2)
  Achievement.create(name: "Followers", level: 2 , url: "/images/solid_earth.png", criteria: 4)
  Achievement.create(name: "Followers", level: 3 , url: "/images/flat_earth.png", criteria: 6)
  Achievement.create(name: "Forks", level: 1 , url: "/images/outline_fork.png", criteria: 1)
  Achievement.create(name: "Forks", level: 2 , url: "/images/solid_fork.png", criteria: 3)
  Achievement.create(name: "Forks", level: 3 , url: "/images/flat_fork.png", criteria: 5)
  Achievement.create(name: "Repos", level: 1 , url: "/images/outline_documents.png", criteria: 3)
  Achievement.create(name: "Repos", level: 2 , url: "/images/solid_documents.png", criteria: 6)
  Achievement.create(name: "Repos", level: 3 , url: "/images/flat_documents.png", criteria: 10)
  Achievement.create(name: "Commits", level: 1 , url: "/images/outline_seat_belt.png", criteria: 50)
  Achievement.create(name: "Commits", level: 2 , url: "/images/solid_seat_belt.png", criteria: 75)
  Achievement.create(name: "Commits", level: 3 , url: "/images/flat_seat_belt.png", criteria: 200)
  Achievement.create(name: "Stars", level: 1 , url: "/images/outline_wizard.png", criteria: 1)
  Achievement.create(name: "Stars", level: 2 , url: "/images/solid_wizard.png", criteria: 3)
  Achievement.create(name: "Stars", level: 3 , url: "/images/flat_wizard.png", criteria: 5)
end

desc "populate the groups table"
task "db:populate_group" do
  Group.destroy_all
  Group.create(name: "Lighthouse Labs")
end

task 'db:create_migration' do
  unless ENV["NAME"]
    puts "No NAME specified. Example usage: `rake db:create_migration NAME=create_users`"
    exit
  end

  name    = ENV["NAME"]
  version = ENV["VERSION"] || Time.now.utc.strftime("%Y%m%d%H%M%S")

  ActiveRecord::Migrator.migrations_paths.each do |directory|
    next unless File.exist?(directory)
    migration_files = Pathname(directory).children
    if duplicate = migration_files.find { |path| path.basename.to_s.include?(name) }
      puts "Another migration is already named \"#{name}\": #{duplicate}."
      exit
    end
  end

  filename = "#{version}_#{name}.rb"
  dirname  = ActiveRecord::Migrator.migrations_path
  path     = File.join(dirname, filename)

  FileUtils.mkdir_p(dirname)
  File.write path, <<-MIGRATION.strip_heredoc
    class #{name.camelize} < ActiveRecord::Migration
      def change
      end
    end
  MIGRATION

  puts path
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end
