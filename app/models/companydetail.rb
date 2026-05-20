class Companydetail < ApplicationRecord
  belongs_to :user
  # Автоматически удаляем случайные пробелы перед валидацией
  before_validation :strip_whitespace

  # 1. Обязательные поля
  validates :name_organization, :inn, :current_account, :recipient_bank_name, :bik, presence: true

  # 2. Валидация ИНН (для ЮЛ — 10 цифр, для ИП — 12 цифр)
  validates :inn, format: { with: /\A\d{10}(\d{2})?\z/, message: "должен состоять из 10 или 12 цифр" }

  # 3. Валидация КПП (9 цифр, обязателен для ЮЛ. Если это ИП, поле может быть пустым)
  validates :kpp, format: { with: /\A\d{9}\z/, message: "должен состоять из 9 цифр" }, allow_blank: true

  # 4. Валидация БИК (9 цифр)
  validates :bik, format: { with: /\A\d{9}\z/, message: "должен состоять из 9 цифр" }

  # 5. Валидация Расчетного счета (20 цифр)
  validates :current_account, format: { with: /\A\d{20}\z/, message: "должен состоять из 20 цифр" }

  # 6. Валидация Корреспондентского счета (20 цифр, может быть пустым для некоторых банков)
  validates :correspondent_account_number, format: { with: /\A\d{20}\z/, message: "должен состоять из 20 цифр" }, allow_blank: true

  private

  # Метод для удаления пробелов, если пользователь случайно скопировал счет с пробелами
  def strip_whitespace
    self.inn = inn&.strip
    self.kpp = kpp&.strip
    self.bik = bik&.strip
    self.current_account = current_account&.strip
    self.correspondent_account_number = correspondent_account_number&.strip
  end
end
