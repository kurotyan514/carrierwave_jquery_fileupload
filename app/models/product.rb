class Product < ActiveRecord::Base
  has_one :photo , dependent: :destroy
end
