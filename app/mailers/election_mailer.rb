
class ElectionMailer < ApplicationMailer
  default from: 'voteelectiontopicos@gmail.com'

  def votation_email
    @user = params[:user]
    @election = params[:election]
    mail(to: @user.email,
      subject: 'VOTAR EN UNA ELECCIÓN') do |format|
      format.html { render 'email_to_vote' }
    end
  end

  def titular_email
    @user = params[:user]
    @election = params[:election]
    mail(to: @user.email,
      subject: 'TU ELECCIÓN HA INICIADO') do |format|
      format.html { render 'titular_email_to_vote' }
    end
  end
end