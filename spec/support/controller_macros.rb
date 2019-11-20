module ControllerMacros
  def login(user) #ログインをするためloginメソッド使用。
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end