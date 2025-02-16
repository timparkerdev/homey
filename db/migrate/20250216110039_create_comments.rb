class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.timestamps

      t.references :commentable, polymorphic: true, null: false

      t.string :content
    end
  end
end
