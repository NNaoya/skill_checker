class CreateSelfintroductions < ActiveRecord::Migration[5.1]
  def change
    create_table :selfintroductions do |t|
      t.string :user_id
      t.string :self_introduction
      t.timestamps
    end
  end
end
