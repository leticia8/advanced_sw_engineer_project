class ElectionsController < ApplicationController
  before_action :authenticate_user!
  
    def index
      @elections = Election.all
    end
   
    def show
      @election = Election.find(params[:id])
    end

    def results
      @election = Election.find(params[:electionId])
      return
    end

    def info
      @election = Election.find(params[:electionId])
    end
   
    def activate_election
      @election = Election.find(params[:electionId])
      if @election.activated == nil || @election.activated == false

        @election = @election.update_attribute(:activated, true)
        return
      end
    end

    helper_method :has_finish
    helper_method :has_started
    helper_method :election_status
    helper_method :activate_status_2

    # Returns true if it is closed, or false if not finished yet
    def has_finish(electionId)
      @election = Election.find(electionId)
      (@election.finish_date.to_i - Time.now.to_i) <= 0
    end

    # Returns true if the election has already opened, or false if the date was not reached
    def has_started(electionId)
      @election = Election.find(electionId)
      (Time.now.to_i - @election.start_date.to_i) >= 0
    end
    
    # Returns a status number for an election
      # 4 is activated and closed
      # 3 is activated and not closed
      # 2 is not activated with proposals (options controlled in activate_state_2 method)
      # 1 is not activated without proposals
    def election_status(electionId)
      @election = Election.find(electionId)  
      if @election.activated and has_finish(electionId)
        4
      elsif @election.activated and !has_finish(electionId)
        3
      elsif !@election.activated
        if @election.proposals.length == 0
          1
        else
          2
        end
      end
    end

    # Returns true if each of the proposals has at least one option
    def activate_status_2(electionId)
      @election = Election.find(electionId)  
      @result = true
      @election.proposals.each do |proposal|
        if proposal.options.length == 0
          @result = false
          break
        end
      end
      @result
    end

    def create
      @election = Election.new(election_params)
      if @election.save
        redirect_to election_path(@election)
      else 
        render :new
      end
    end 

    private
    def election_params
      params.require(:election).permit(:id, :description, :start_date, :finish_date, :user_id, :segmented_by, :condition, :created_at, :updated_at, :activated)
    end
end
