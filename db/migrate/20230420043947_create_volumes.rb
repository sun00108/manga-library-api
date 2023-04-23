class CreateVolumes < ActiveRecord::Migration[6.1]
  def change
    create_table :volumes do |t|
      t.references :manga, null: false, foreign_key: true
      t.integer :number

      t.timestamps
    end
  end
end
