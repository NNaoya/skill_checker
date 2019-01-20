class CreateUserskills < ActiveRecord::Migration[5.1]
  def change
    create_table :userskills do |t|
      t.string :user_id
      t.string :skill_id
      t.string :level
      t.string :comment
      t.timestamps
    end
  end
end
