class Pharmacy < ApplicationRecord
  has_one :opening_time
  has_many :mask_pharmacies
  has_many :masks, through: :mask_pharmacies
  
  has_many :purchase_histories
end
