class ChaptersController < ApplicationController

  def fetch_pages_by_chapter
    chapter = Chapter.find(params[:chapter_id])
    next_chapter_num = chapter.number + 1
    next_chapter = Chapter.find_by(manga_id: chapter.manga_id, number: next_chapter_num)
    next_chapter_id = next_chapter.present? ? next_chapter.id : nil
    pages = chapter.pages.sort_by(&:number)
    render json: { code: 0, message: '', data: { pages: pages, next_chapter: next_chapter_id } }
  end

end
