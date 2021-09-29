namespace :scheduled_tasks do
  desc "This task send mail to vote"
  task send_vote_mail: :environment do
    puts "Sending mails to vote..."
    t = Time.new
    Election.where("DATE(start_date)=? and extract(hour from start_date)=?",Date.today,t.hour).find_each do |eachEl|
      @segmented_by=eachEl.segmented_by
      @election=eachEl
      @userCreat=User.find_by(id:@election.user_id)
      if @election.activated 
      case @segmented_by
      when'state' 
        User.where(state: @election.condition).find_each do |eachUser|
        @user=eachUser
        ElectionMailer.with(user: @user, election: @election).votation_email.deliver_now
        end
      when 'city' 
        User.where(city: @election.condition).find_each do |eachUser|
        @user=eachUser
        ElectionMailer.with(user: @user, election: @election).votation_email.deliver_now
        end
      when 'age'  
        @ageRange=@election.condition.split('-')
        # now we need to check age condition
        if @ageRange.length > 1     # case like (30-45)
          @youngerDate=@ageRange[0].to_i < @ageRange[1].to_i ? @ageRange[0].to_i : @ageRange[1].to_i
          @olderDate=@ageRange[0].to_i > @ageRange[1].to_i ? @ageRange[0].to_i : @ageRange[1].to_i
          User.where('birth_date BETWEEN ? AND ?', @olderDate.years.ago , @youngerDate.years.ago).find_each do |eachUser|
          @user=eachUser
          ElectionMailer.with(user: @user, election: @election).votation_email.deliver_now
          end
        else                        # case 61 or more
          User.where('birth_date BETWEEN ? AND ?', 61.years_ago , 140.years_ago).find_each do |eachUser|
          @user=eachUser
          ElectionMailer.with(user: @user, election: @election).votation_email.deliver_now
          end
        end  
      end
      ElectionMailer.with(user: @userCreat, election: @election).titular_email.deliver_now
    end
  end
    puts "Task send mail to vote finished"
  end
  
  desc "This task send mails to see results"
  task send_see_results_mail:  :environment do
  puts "Sending mails to see results..."
  t = Time.new
  @election=Election.where("DATE(finish_date)=? and extract(hour from finish_date)=? ",Date.today,t.hour-1)
    @election.each do |eachEl|
      @oneEl=eachEl
      @userCreat=User.find_by(id:@oneEl.user_id)
      @user=UserElection.where(election_id:eachEl.id)
      @user.each do |eachUs|  
          @finUs=User.find_by(id:eachUs.user_id)
          ResultsMailer.with(user: @finUs, election: @oneEl).results_email.deliver_now
      end
      ResultsMailer.with(user: @userCreat, election: @oneEl).titular_email.deliver_now
  end
    puts "Task send mail to see results finished"
  end
  
  end