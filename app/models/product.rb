class Product < ApplicationRecord
  has_many :comment_products

  scope :get_info, lambda{
    where('is_parking = ?', true)
  }

  def get_average_start
    CommentProduct.average(:star).to_f.round(2)
  end

  def get_info
    Product.select(:id, :name, :brand)
  end

  def get_comments
    comments = CommentProduct.all
    comments.each do |comment|
      comment.client.name
      comment.client.email
    end

    comments
  end
end
