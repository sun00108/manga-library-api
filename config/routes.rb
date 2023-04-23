Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/api/v1/manga', to: 'mangas#fetch_mangas'
  get '/api/v1/manga/reading', to: 'mangas#fetch_reading_by_user'
  get '/api/v1/manga/:id', to: 'mangas#fetch_manga_by_id'
  get '/api/v1/manga/:id/chapter/:chapter_id', to: 'mangas#fetch_pages_by_chapter'

  get '/api/v1/user/profile', to: 'users#fetch_profile'

  get '/api/v1/chapter/:chapter_id/pages', to: 'chapters#fetch_pages_by_chapter'

  get '/api/v1/page/:page_id', to: 'pages#fetch_image_by_page'

  devise_for :users, path: '', path_names: {
    sign_in: '/api/v1/user/login',
    registration: '/api/v1/user/register'
  },
  controllers: {
   sessions: 'users/sessions',
   registrations: 'users/registrations'
  }

end
