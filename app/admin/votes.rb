ActiveAdmin.register Vote do
    permit_params :vote_date, :option_id
  
    index do
      selectable_column
      id_column
      column :vote_date
      column :option do |obj|
        link_to obj.option.description, admin_option_path(obj.option)
      end
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :vote_date
        f.input :option, as: :select, 
          collection: Option.all.map { |option| [option.description, option.id] }
      end
      f.actions
    end
  
  end
  