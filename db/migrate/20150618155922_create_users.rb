class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.references :group
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :token
      t.string :avatar_url
      t.string :location
      t.integer :followers
      t.integer :public_repos
      t.integer :public_gists
      t.date :start_date
      t.timestamps null: false
    end
  end
end
