Gocritik::Application.routes.draw do
  #[FIXME] use namespace
  scope '/admin' do
    resources :fields do
      #[FIXME] fix this route
      post 'fields/create_collection', on: :collection
    end
    resources :resources, path: ResourceName.pluralize.downcase
  end
  
  get 'admin' => 'admin#home'

end
