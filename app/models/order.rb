class Order < ApplicationRecord
  belongs_to :user
  belongs_to :service
  has_many_attached :images
end
