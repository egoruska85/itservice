class OrganizationsController < ApplicationController
  before_action :authenticate_user!, :check_organization_access

  def index

  end

  protected

  def check_organization_access
    if current_user.block?
      sign_out current_user
      redirect_to new_user_session_path, alert: "Ваш аккаунт заблокирован." and return
    end

    # Сюда пускаем ТОЛЬКО организации. Если юзер НЕ организация — это нарушение
    unless current_user.organization?
      session[:failed_organization_attempts] ||= 0
      session[:failed_organization_attempts] += 1

      if session[:failed_organization_attempts] >= 5
        session[:failed_organization_attempts] = 0
        current_user.update(block: true)
        sign_out current_user
        redirect_to new_user_session_path, alert: "Система заподозрела подозрительную активность с вашего аккаунта. Аккаунт заблокирован!" and return
      else
        remaining = 5 - session[:failed_organization_attempts]
        # Отправляем нарушителя на страницу частных клиентов
        redirect_to privates_path, alert: "Вам нельзя на страницу организаций. Осталось попыток: #{remaining}." and return
      end
    end

    # Если всё хорошо и зашел тот, кто надо — обнуляем конкретно ЭТОТ счетчик
    session[:failed_organization_attempts] = 0
  end

end
