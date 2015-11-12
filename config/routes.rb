Spree::Core::Engine.routes.draw do

  resources :orders, :except => [:index, :new, :create, :destroy] do
      post :variant_populate, :on => :collection
  end

end
