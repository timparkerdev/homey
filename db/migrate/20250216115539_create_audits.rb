class CreateAudits < ActiveRecord::Migration[8.0]
  def change
    create_table :audits do |t|
      t.timestamps

      t.references :auditable, polymorphic: true, null: false

      t.string :action
      t.json :raw_changes
    end
  end
end
