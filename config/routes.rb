Rails.application.routes.draw do
  get 'object_records/index'
  get 'object_records/delete_all'
  root "object_records#index"
  match "/search" => "object_records#search", via: [:post]
  match "/import" => "object_records#import", via: [:post]
end
