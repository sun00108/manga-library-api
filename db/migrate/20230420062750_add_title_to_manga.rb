class AddTitleToManga < ActiveRecord::Migration[6.1]
  def change
    add_column :mangas, :title, :string
  end
end
