ActiveAdmin.register Proposal do
    permit_params :name, :description, :election_id
  
    index do
      selectable_column
      id_column
      column :name
      column :description
      column :election do |obj|
        link_to obj.election.description, admin_election_path(obj.election)
      end
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :name
        f.input :description
        f.input :election, as: :select, 
          collection: Election.all.map { |election| [election.description, election.id] }
      end
      f.actions
    end
  
  end
  