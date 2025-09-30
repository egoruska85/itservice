class Service < ApplicationRecord
  has_one_attached :picture
  has_many_attached :pictures
end
