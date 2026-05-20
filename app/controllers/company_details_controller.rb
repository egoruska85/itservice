class CompanyDetailsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    # Ищем реквизиты строго среди записей текущего пользователя для безопасности
    @companydetail = current_user.companydetails.find(params[:id])
    @companydetail.destroy

    redirect_to company_details_organizations_path, notice: 'Реквизиты успешно удалены!', status: :see_other
  end
end
