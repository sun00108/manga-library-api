namespace :cleanup do
  desc "Delete all Manga, Volume, Chapter, Page records and associated files"
  task clear_all: :environment do
    # 删除所有Page记录并清理关联的文件
    puts "Deleting all pages and their files..."
    Page.all.each do |page|
      page.image.purge if page.image.attached?
      page.destroy
    end

    # 删除所有Chapter记录
    puts "Deleting all chapters..."
    Chapter.delete_all

    # 删除所有Volume记录
    puts "Deleting all volumes..."
    Volume.delete_all

    # 删除所有Manga记录
    puts "Deleting all mangas..."
    Manga.delete_all

    puts "Cleanup completed!"
  end
end
