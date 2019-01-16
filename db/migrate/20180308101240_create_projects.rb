class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :user_id
      t.string :project_period
      t.string :project_name
      t.string :project_overview
      t.string :phase
      t.string :business
      t.string :technical_element

      t.timestamps
    end
  end
end
