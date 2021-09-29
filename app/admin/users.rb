ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :admin, :name, :country,
    :state, :city, :birth_date

  index do
    selectable_column
    id_column
    column :email
    column :admin
    column :name
    column :country
    column :state
    column :city
    column :birth_date
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :name
      f.input :country
      f.input :state
      f.input :city
      f.input :birth_date
      f.input :admin
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
