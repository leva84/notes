class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.belongs_to :user, foreign_key: true, index: true, null: false
      t.text :message

      t.timestamps
    end
  end
end
