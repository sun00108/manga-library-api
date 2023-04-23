class PagesController < ApplicationController

  def fetch_image_by_page
    # 增加用户获取记录
    page = Page.find(params[:page_id])
    render json: { code: 0, message: '', data: page.image.attached? ? url_for(page.image) : nil }
  end

end
