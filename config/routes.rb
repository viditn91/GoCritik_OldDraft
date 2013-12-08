Gocritik::Application.routes.draw do

  scope '/admin' do
    resources :fields do
      post 'fields/create_collection', on: :collection
    end
    resources :resources, path: ResourceName.pluralize.downcase
  end
  
  get 'admin' => 'admin#home'

end
