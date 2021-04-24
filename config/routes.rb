Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'forecast', to: 'weather#get_forecast'
    end
  end
end
