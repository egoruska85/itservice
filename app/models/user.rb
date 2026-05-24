class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
         attr_writer :login
     validate :validate_username

     def login
       @login || username || email || phone
     end
     # app/models/user.rb

     def self.find_for_database_authentication(warden_conditions)
       conditions = warden_conditions.dup
       if (login = conditions.delete(:login))
         where(conditions.to_h).where([
           "lower(username) = :value OR lower(email) = :value OR phone = :value",
           { value: login.downcase }
         ]).first
       elsif conditions.has_key?(:username) || conditions.has_key?(:email) || conditions.has_key?(:phone)
         where(conditions.to_h).first
       end
     end
   def validate_username
     if User.where(email: username).exists?
       errors.add(:username, :invalid)
     end
   end

   validate :cannot_be_both_private_and_organization

   private

   def cannot_be_both_private_and_organization
      if private? && organization?
        errors.add(:base, "Пользователь не может быть одновременно частным клиентом и организацией")
      elsif admin? && organization?
        errors.add(:base, "Администраторы не могу быть организацией")
      elsif admin? && private?
        errors.add(:base, "Администраторы не могу быть частным клиентом")
      end
   end

   has_many :companydetails
   has_many :messages
end
