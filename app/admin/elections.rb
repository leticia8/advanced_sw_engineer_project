ActiveAdmin.register Election do
    permit_params :description, :start_date, :finish_date, :user_id, :segmented_by, :condition
  
    index do
      selectable_column
      id_column
      column :description
      column :start_date
      column :finish_date
      column :user
      column :segmented_by
      column :condition
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :description
        f.input :start_date
        f.input :finish_date
        f.input :user, as: :select, collection: User.all.map { |user| [user.email, user.id] }
        f.input :segmented_by
        f.input :condition
      end
      f.actions
    end
  
  end
  