class RegistrationsController < Devise::RegistrationsController
    private

    def sign_up_params
      params.require(:user).permit(:name, :email, :country, :state, :city, :birth_date, :password, :password_confirmation)
    end
  
    def account_update_params
      params.require(:user).permit(:name, :email, :country, :state, :city, :birth_date, :current_password,
                                   :password, :password_confirmation)
    end
  end
  