
class ResultsMailer < ApplicationMailer
  default from: 'voteelectiontopicos@gmail.com'
 
  def results_email
    @user = params[:user]
    @election = params[:election]
    mail(to: @user.email,
      subject: 'VER RESULTADOS DE UNA ELECCIÓN') do |format|
      format.html { render 'email_to_results' }

    end
  end


def titular_email
  @user = params[:user]
  @election = params[:election]
  mail(to: @user.email,
    subject: 'TU ELECCIÓN HA CULMINADO - VE LOS RESULTADOS') do |format|
    format.html { render 'titular_email_to_results' }
  end
end
end