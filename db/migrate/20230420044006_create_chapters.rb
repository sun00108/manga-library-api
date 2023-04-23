class CreateChapters < ActiveRecord::Migration[6.1]
  def change
    create_table :chapters do |t|
      t.references :manga, null: false, foreign_key: true
      t.references :volume, null: true, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
