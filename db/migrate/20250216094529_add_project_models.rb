class AddProjectModels < ActiveRecord::Migration[8.0]
  def change
    create_table :project_statuses do |t|
      t.timestamps

      t.string :name
      t.string :color
    end

    create_table :projects do |t|
      t.timestamps

      t.string :name
      t.string :description
      t.references :project_statuses
    end
  end
end
