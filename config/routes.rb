Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'weather#forecast'
      get 'backgrounds', to: 'backgrounds#background_image'
    end
  end
end
