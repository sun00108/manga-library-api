namespace :import_manga do
  desc "从文件夹中导入漫画文件"
  task :import, [:manga_root_dir] => :environment do |_task, args|

    def parse_manga_directory(manga_dir)
      title = File.basename(manga_dir)
      # 检查是否已经存在具有相同标题的Manga
      existing_manga = Manga.find_by(title: title)
      # 如果已存在相同标题的Manga，跳过此文件夹
      if existing_manga
        puts "Manga with title '#{title}' already exists. Skipping..."
        return
      end
      manga = Manga.find_or_create_by(title: title)
      Dir.glob("#{manga_dir}/*").each do |volume_or_chapter_dir|
        if contains_images?(volume_or_chapter_dir)
          # 子文件夹包含图片，表示这是一个Chapter
          parse_chapter_directory(volume_or_chapter_dir, manga)
        else
          # 子文件夹包含其他文件夹，表示这是一个Volume
          parse_volume_directory(volume_or_chapter_dir, manga)
        end
      end
    end

    def parse_volume_directory(volume_dir, manga)
      volume_number = extract_number_from_dir_name(volume_dir)
      volume = Volume.find_or_create_by(manga: manga, number: volume_number)

      Dir.glob("#{volume_dir}/*").each do |chapter_dir|
        parse_chapter_directory(chapter_dir, manga, volume)
      end
    end

    def parse_chapter_directory(chapter_dir, manga, volume = nil)
      chapter_number = extract_number_from_dir_name(chapter_dir)
      chapter = Chapter.find_or_create_by(manga: manga, volume: volume, number: chapter_number)

      sorted_image_files = Dir.glob("#{chapter_dir}/*.{jpg,jpeg,png,gif}")
                              .sort_by { |file| extract_number_from_file_name(file) }

      page_counter = 1

      sorted_image_files.each do |image_file|
        # 确保在创建Page对象时设置了chapter关联
        page = Page.find_or_create_by(chapter_id: chapter.id, number: page_counter)
        page.image.attach(io: File.open(image_file), filename: File.basename(image_file), content_type: mime_type_for_file(image_file))
        page_counter += 1
      end
    end


    def contains_images?(dir)
      !Dir.glob("#{dir}/*.{jpg,jpeg,png,gif}").empty?
    end

    def extract_number_from_dir_name(dir_name)
      File.basename(dir_name).match(/\d+/).to_s.to_i
    end

    def extract_number_from_file_name(file_name)
      File.basename(file_name, File.extname(file_name)).match(/\d+/).to_s.to_i
    end

    def mime_type_for_file(file)
      case File.extname(file).downcase
      when '.jpg', '.jpeg'
        'image/jpeg'
      when '.png'
        'image/png'
      when '.gif'
        'image/gif'
      else
        'application/octet-stream'
      end
    end

    # 使用命令行参数中传递的路径
    manga_root_dir = args.manga_root_dir
    Dir.glob("#{manga_root_dir}/*").each do |manga_dir|
      parse_manga_directory(manga_dir)
    end

  end
end