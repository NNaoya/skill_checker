class CreateQualifications < ActiveRecord::Migration[5.1]
  def change
    create_table :qualifications do |t|
      t.string :user_id
      t.string :qualification

      t.timestamps
    end
  end
end
