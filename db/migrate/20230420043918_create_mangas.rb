class CreateMangas < ActiveRecord::Migration[6.1]
  def change
    create_table :mangas do |t|

      t.timestamps
    end
  end
end
