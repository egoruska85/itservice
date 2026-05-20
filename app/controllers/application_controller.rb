class ApplicationController < ActionController::Base
  before_action :set_locale, :set_variable, :set_mailer_settings, :check_signed_user
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end
  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end
  def default_url_options
    { locale: I18n.locale }
  end
  def set_variable
    @organization = Organization.first
    @a = -1
    @time = Time.now
    @carouseles = Carousel.all
  #@carouseles = Carousel.all

  end

  protected

  def check_signed_user
    if user_signed_in?
      after_sign_in_path_for(current_user)
      check_block_user
    end
  end

  def check_block_user
    if current_user.block?
      sign_out current_user
      redirect_to root_path, alert: "Вход запрещён вы заблокированы системой."
    end
  end


  def after_sign_in_path_for(resource)
    if resource.private?
      privates_path        # На страницу частного клиента
    elsif resource.organization?
      organizations_path   # На страницу организации
    elsif resource.admin?
      backoffices_path
    else
      root_path            # Если галочки не стоят — на главную страницу
    end
  end

  def set_mailer_settings
    @mail_params = Mailparametr.first
    return unless @mail_params

    ActionMailer::Base.smtp_settings = {
      address:              @mail_params.address,
      port:                 @mail_params.port,
      domain:               @mail_params.domain,
      user_name:            @mail_params.username,
      password:             @mail_params.password,
      authentication:       @mail_params.authentication,
      enable_starttls_auto: @mail_params.enable_starttls_auto
    }
  end

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
