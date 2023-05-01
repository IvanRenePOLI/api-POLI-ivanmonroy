class CommentProduct < ApplicationRecord
  belongs_to :client
  belongs_to :product

  def client_exists email
    Client.where('email = ?', email).exists?
  end
end
