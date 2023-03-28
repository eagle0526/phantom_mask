Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :mask_pharmacies do
    collection do
      get :mask_count
      get :name_relevance

    end
  end
end
