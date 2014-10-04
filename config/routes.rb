TasklistChallenge::Application.routes.draw do
  resources :tasks, exclude: [:show]
  post 'tasks/:id/marker' => 'tasks#marker'
  post 'tasks/:id/archiver' => 'tasks#archiver'
  post 'tasks/:id/unarchiver' => 'tasks#unarchiver'
  root 'tasks#index'
  get 'readme' => 'docs#readme', as: :readme
  get 'maps' => 'maps#show', as: :maps
end
