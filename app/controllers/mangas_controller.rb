class MangasController < ApplicationController

  def fetch_mangas
    mangas = Manga.all
    mangas_data = mangas.map do |manga|
      cover_image_url = manga.cover_image.attached? ? url_for(manga.cover_image) : nil
      {
        id: manga.id,
        title: manga.title,
        cover_image_url: cover_image_url
      }
    end
    render json: { code: 0, message: '', data: mangas_data }
  end

  def fetch_reading_by_user
    manga = Manga.find(2)
    manga_data = {
      id: manga.id,
      title: manga.title,
      cover_image_url: manga.cover_image.attached? ? url_for(manga.cover_image) : nil
    }
    puts manga_data
    render json: { code: 0, message: '', data: manga_data }
  end


  def fetch_manga_by_id
    manga = Manga.find(params[:id])
    manga_data = {
      id: manga.id,
      title: manga.title,
      cover_image_url: manga.cover_image.attached? ? url_for(manga.cover_image) : nil
    }
    volumes = manga.volumes
    chapters = manga.chapters
    render json: { code: 0, message: '', data: { manga: manga_data, volumes: volumes, chapters: chapters } }
  end

  def fetch_pages_by_chapter
    manga = Manga.find(params[:id])
    chapter = Chapter.find(params[:chapter_id])
    pages = chapter.pages
    render json: { code: 0, message: '', data: { manga: manga, pages: pages } }
  end

end
