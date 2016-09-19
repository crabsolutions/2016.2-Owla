class Topic < ApplicationRecord

  belongs_to :room
  has_many :questions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 255, minimum: 2 }, uniqueness: { case_sensitive: false } 
  #has_many :answers

end
