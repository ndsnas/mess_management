Rails.application.routes.draw do



  root 'front#index'



  get 'student/view_menu'
  get 'student/view_bill'
  get 'student/apply_mess'
  get 'student/pay_bill'
  get 'student/purchase_history'
  get 'student/change_password'
  get 'student/feedback'

  #resources :manager
  get 'manager/add_student'
  post 'manager/add_student'
  get 'manager/delete_student'
  get 'manager/view_menu'
  get 'manager/update_menu'
  get 'manager/add_mess_cut'
  get 'manager/update_mess_cut'
  get 'manager/per_month_fee_detail'
  get 'manager/extra_per_day'
  get 'manager/backup_db'
  get 'manager/view_stock'
  get 'manager/update_stock'
  get 'manager/monthly_profit_analysis'
  get 'manager/view_feedback'
  post 'manager/create'




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
