class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :books,dependent: :destroy
         attachment :profile_image

  validates :name, presence: true,
            length: { minimum: 2, maximum: 20}
  validates :password, presence: true
  validates :introduction, presence: true,
            length: {maximum: 50}

  def introduction_required?
    super if confirmed?
  end
end