ActiveAdmin.register Option do
    permit_params :description, :proposal_id
  
    index do
      selectable_column
      id_column
      column :description
      column :proposal
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :description
        f.input :proposal, as: :select, 
          collection: Proposal.all.map { |proposal| [proposal.name, proposal.id] }
      end
      f.actions
    end
  
  end
  