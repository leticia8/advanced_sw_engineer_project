class ProposalsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @election = Election.find(params[:election_id])
    @proposal = @election.proposals.create(proposal_params)
    redirect_to election_path(@election)
  end

  def show
    @proposal = Proposal.find(params[:id])
  end
 
  private
  
  def proposal_params
    params.require(:proposal).permit(:name, :description, :election_id)
  end
end