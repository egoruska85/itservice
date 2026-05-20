class PrivatesController < ApplicationController
  before_action :authenticate_user!, :check_private_access

  def index

  end

  protected

  def check_private_access
    if current_user.block?
      sign_out current_user
      redirect_to new_user_session_path, alert: "Ваш аккаунт заблокирован!." and return
    end

    # Сюда пускаем ТОЛЬКО приватных. Если юзер НЕ приватный — это нарушение
    unless current_user.private?
      session[:failed_private_attempts] ||= 0
      session[:failed_private_attempts] += 1

      if session[:failed_private_attempts] >= 5
        session[:failed_private_attempts] = 0
        current_user.update(block: true)
        sign_out current_user
        redirect_to new_user_session_path, alert: "Система заподозрела подозрительную активность с вашего аккаунта. Аккаунт заблокирован!" and return
      else
        remaining = 5 - session[:failed_private_attempts]
        # Отправляем нарушителя на страницу организаций
        redirect_to organizations_path, alert: "Вам нельзя на страницу частных клиентов" and return
      end
    end

    # Если всё хорошо и зашел тот, кто надо — обнуляем конкретно ЭТОТ счетчик
    session[:failed_private_attempts] = 0
  end
end
