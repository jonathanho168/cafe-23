Rails.application.routes.draw do
  # API routing
  scope module: 'api', defaults: {format: 'json'} do
    namespace :v1 do
      # provide the routes for the API here

      get 'employees', to: 'employees#index', as: :employees
      get 'shifts/:id', to: 'shifts#show', as: :shift
      get 'stores/:id/upcoming', to: 'shifts#upcoming', as: :upcoming_shifts

      # resources :employees
      # resources :shifts
      # resources :stores
      

      

    end
  end

  # Routes for regular HTML views go here...
  
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy

  resources :sessions
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout


  resources :employees
  resources :assignments
  # resources :sessions
  resources :pay_grades, except: [:destroy]
  resources :stores, except: [:destroy]
  resources :payrolls
  # get 'employee_form', to: 'payrolls#employee_form', as: :employee_form
  get 'store_payroll', to: 'payrolls#store_payroll', as: :store_payroll
  get 'employee_payroll', to: 'payrolls#employee_payroll', as: :employee_payroll
  get 'store_form', to: 'payrolls#store_form', as: :store_form
  resources :pay_grade_rates, only: [:new, :create]
  resources :shift_jobs, only: [:new, :create, :destroy]
  resources :shifts
  patch 'time_in', to: 'shifts#time_in', as: :time_in
  patch 'time_out', to: 'shifts#time_out', as: :time_out
  get 'time_clock', to: 'shifts#time_clock', as: :time_clock

  get 'employee_form', to: 'payrolls#employee_form', as: :employee_form

  resources :jobs, except: [:show]
  # resources :jobs, only: [:index, :new, :edit, :create, :update, :destroy]
  # resources :stores

  root 'home#index'




  # You can have the root of your site routed with 'root'
  
  
end
