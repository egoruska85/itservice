class OrganizationsController < ApplicationController
  before_action :authenticate_user!, :check_organization_access

  def index
    @companydetails = Companydetail.where(user_id: current_user.id)

    # Инициализируем пустой объект для формы добавления новых реквизитов
    @companydetail = current_user.companydetails.build
  end

  def show
    @user = User.find(params[:id])

    if @user != current_user
      redirect_to organization_path(current_user), alert: "Доступ запрещен"
    end
  end

  def create_company_details
    @companydetail = Companydetail.new(company_detail_params)
    @companydetail.user_id = current_user.id
    if @companydetail.save
       redirect_to organizations_path, notice: "Реквизиты созданы"
    end
  end

  private

  def company_detail_params
    params.require(:companydetail).permit(:name_organization, :inn, :kpp, :current_account, :recipient_bank_name, :bik, :correspondent_account_number, :additionally, :user_id)
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
        redirect_to privates_path, alert: "Вам нельзя на страницу организаций." and return
      end
    end

    # Если всё хорошо и зашел тот, кто надо — обнуляем конкретно ЭТОТ счетчик
    session[:failed_organization_attempts] = 0
  end

end
