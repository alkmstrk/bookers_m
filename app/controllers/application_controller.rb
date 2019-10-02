class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resourse)
    user_path(resourse)
  end

  def after_sign_out_path_for(resourse)
   root_path
  end

  protected

    # devise.rbを編集したことにより、nameは受け付けるが、emailは受け付けなくなる。なのでストロングパラメーターにemailを追加
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
    end

end
