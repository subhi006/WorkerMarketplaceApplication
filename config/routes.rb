Rails.application.routes.draw do
  devise_for :users
  # mount Motor::Admin => "/motor_admin"

  resources :payments, only: [ :new, :create ]
  get "payments/success", to: "payments#success"
  get "payments/cancel", to: "payments#cancel"

  root "home#index"

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
  get "/contractor/tasks/:task_id/applications", to:  "contractor/applications#per_task_appliation", as: "contractor_per_task_appliation"
  get "/contractor/tasks/:task_id/work_start", to:  "contractor/tasks#work_start", as: "contractor_work_start"

  namespace :worker do
    resources :tasks, only: [ :index, :show ] do
      resource :applications, only: [ :create ]
    end
    resources :applications, only: [ :index, :show ]
  end

  resources :notifications, only: [ :index, :show ] do
    member do
      get :mark_as_read
    end
  end

  resources :profiles
  resource :reviews
end
