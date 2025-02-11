Rails.application.routes.draw do
  mount Motor::Admin => "/motor_admin"
  resources :payments, only: [ :new, :create ]
  # post "payments/create", to: "payments#create"
  get "payments/success", to: "payments#success"
  get "payments/cancel", to: "payments#cancel"

  devise_for :users
  resources :users
  root "home#index"
  resources :home, only: [ :show ]
  # resources :admin, only: [ :index, :create, :update ]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  namespace :contractor do
    resources :tasks do
         member do
            post :task_post
         end
    end
    resources :applications, only: [ :index ] do
      member do
        get :approve
        get :reject
      end
    end
  end
  resources :assigned_tasks, only: [ :index, :show ]
  # get "/assigned_tasks", to: "assigned_tasks#index", as: "assigned_tasks"
  get "/contractor/tasks/:task_id/applications", to:  "contractor/applications#per_task_appliation", as: "contractor_per_task_appliation"
  get "/contractor/tasks/:task_id/work_start", to:  "contractor/tasks#work_start", as: "contractor_work_start"
  get "/profiles/:id/joining_status", to:  "profiles#joining_status", as: "joining_status"

  # get "/contractor/applications", to:  "contractor/applications#search", as: "contractor_application_search"
  namespace :worker do
    resources :tasks, only: [ :index, :show ] do
      resource :applications, only: [ :create ]
    end
    resources :applications, only: [ :index, :show ]
  end
  resources :profiles
  resources :notifications, only: [ :index, :show ] do
    member do
      get :mark_as_read
    end
  end
  # get "/notifications/unread", to:  "notifications#unread", as: "notifications_unread"

  # get ‘/twilio/sms’
  # post ‘/twilio/sms’
  # Defines the root path route ("/")
  # root "posts#index"
end
