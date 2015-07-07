class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.string :name
      t.integer :level
      t.string :url
      t.integer :criteria
      t.timestamps null: false
    end
  end
end
