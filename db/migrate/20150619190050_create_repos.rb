class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.references :user
      t.string :name
      t.integer :stars_count
      t.integer :forks_count
      t.integer :commits_count
      t.string :language
      t.timestamps null: false
    end
  end
end
