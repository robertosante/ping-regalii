class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id, index: true, foreign_key: true, null: false
      t.integer :challenger_id, index: true, foreign_key: true, null: false
      t.integer :user_score, default: 0
      t.integer :challenger_score, default: 0
      t.date :game_date, null: false

      t.timestamps null: false
    end
  end
end
