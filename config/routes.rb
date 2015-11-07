Elements::Engine.routes.draw do
  resources :menus
  resources :chips
  resources :attachments
  resources :pictures
  resources :galleries do
    member do
      get :versions
      get :field_versions
      put :revert
      get :attachments
      put :add_attachment
      put :remove_attachment
    end
  end
  resources :contents do
    member do
      get :versions
      get :field_versions
      put :revert
      get :attachments
      put :add_attachment
      put :remove_attachment
    end
  end
  resources :pages do
    member do
      get :versions
      get :field_versions
      put :revert
      get :attachments
      put :add_attachment
      put :remove_attachment
    end
  end
end
