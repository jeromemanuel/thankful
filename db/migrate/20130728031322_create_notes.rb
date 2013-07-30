class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :content
      t.string :image
      t.string :tags

      t.timestamps
    end
  end
end
