class ApplicationController < ActionController::Base

  # 最初にストロングパラメーターを呼び出す
  before_action :configure_permitted_parameters, if: :devise_controller?

# ログイン後マイページに遷移
  def after_sign_in_path_for(resourse)
    user_path(resourse)
   end

# ログアウト後トップページに遷移
   def after_sign_out_path_for(resourse)
    root_path(resourse)
   end

#protected・・・呼び出された他のコントローラーからも参照できる、サブクラスまでいける
# privateはそのクラス内だけ
protected
# 名前でログインすることを許可する,会員登録は名前とメアドを入力する必要がある
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
