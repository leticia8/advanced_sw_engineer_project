class OptionsController < ApplicationController
  before_action :authenticate_user!

    def create
      @proposal = Proposal.find(params[:proposal_id])
      @option = @proposal.options.create(option_params)
      redirect_to proposal_path(@proposal)
    end
   
    private
      def option_params
        params.require(:option).permit(:description, :proposal_id)
      end
  
end
