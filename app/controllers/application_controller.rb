class ApplicationController < ActionController::Base
  before_action :set_locale, :set_variable, :set_mailer_settings
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
