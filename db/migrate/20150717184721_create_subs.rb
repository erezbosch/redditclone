class CreateSubs < ActiveRecord::Migration
  def change
    create_table :subs do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :user_id, null: false, index: true
      t.timestamps null: false
    end
  end
end
