class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_one    :order
  # has_many   :comments

  belongs_to :category
  belongs_to :prefecture
  belongs_to :item_status
  belongs_to :shipping_cost
  belongs_to :shipping_date

  has_one_attached :image

  with_options presence: true do
    #user_idはアソシエーションで既に記述されているので不要
    validates :name
    validates :description
    validates :category_id
    validates :item_status_id	
    validates :shipping_cost_id
    validates :shipping_date_id
    validates :image
    validates :prefecture_id
    validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  end
  
  with_options numericality: { other_than: 0 } do
    validates :category_id
    validates :prefecture_id
    validates :item_status_id
    validates :shipping_cost_id
    validates :shipping_date_id
  end
end
