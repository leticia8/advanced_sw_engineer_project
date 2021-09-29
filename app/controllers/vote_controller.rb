class VoteController < ApplicationController
    before_action :authenticate_user!
    helper_method :can_vote

    def index
        @vote = Vote.all
    end

    def show
        @vote = Vote.find(params[:id])
    end

    def new 
        @election = Election.find(params[:electionId])
        @has_proposals = @election.proposals.count > 0
        @can_vote = can_vote(@election.id)
        @user_already_vote = user_alredy_vote(@election.id)
        @user_can_vote = validate_segmentation(@election.id)
    end
    
    def create
        @election = Election.find(params[:electionId])
        @voteDate = DateTime.current()
        votes = params[:optionsId].split(',')
        @user = User.find(current_user.id) #current_user
        @user_can_vote = user_can_vote(@election.id)
        
        if !@user_can_vote
            flash.alert = "El usuario no puede votar esta elección"
            return
        end

        unless @election.users_that_vote.include?(@user)
            votes.each do |optionId|
                @vote = Vote.new({option_id: optionId, vote_date: @voteDate})
                @vote.save
            end
            @user.elections_voted << @election
        end
        
        #redirect_to vote_path(@vote)
    end

    private

    def vote_params
        params.require(:optionId)
    end

    # Returns true if the election is in the open voting period, false for the contrary
    def can_vote(electionId)
        @election = Election.find(electionId)
        @start = Time.now.to_i - @election.start_date.to_i
        @finish = @election.finish_date.to_i - Time.now.to_i
        if @finish > 0 and @start > 0
        true
        else
        false
        end
    end

    def user_can_vote(electionId)
        return !user_alredy_vote(electionId) && validate_segmentation(electionId)
    end

    def user_alredy_vote(electionId)
        @voteElection = UserElection.where(user_id: current_user.id, election_id: electionId)
        if @voteElection.empty?
            return false
        else
            return true
        end
    end

    def validate_segmentation(electionId)
        @user = User.find(current_user.id)
        @election = Election.find(electionId)
        @segmented_by = @election.segmented_by
        
        case @segmented_by
        when 'city'
            if @user.city != @election.condition
                return false
            end
        when 'state'
            if @user.state != @election.condition
                return false
            end
        when 'age'
            return age_in_range(@user.birth_date, @election.condition)
        else
            return false
        end
        return true
    end

    # date parameter is user birthdate, range parameter is a string with election range like (30-45) or (61 and more)
    def age_in_range(date, range)
        @age = ((Time.zone.now - date.to_time) / 1.years.seconds).to_i
        @election_range = range.split('-')
        if @election_range.length > 1       # commom case like (30-45)
            return !(@age < @election_range[0].to_i || @age > @election_range[1].to_i)
        else                                # case 61 or more
            return @age >= 61
        end
    end

end
