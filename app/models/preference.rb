class Preference < ApplicationRecord
  # Direct associations

  has_many   :restaurants,
             :dependent => :destroy

  has_many   :shops,
             :dependent => :destroy

  has_many   :routes,
             :dependent => :destroy

  has_many   :users,
             :dependent => :destroy

  # Indirect associations

  # Validations
 validates :taste, presence: true
 validates :style, presence: true
 validates :gender, presence: true
 validates :taste, uniqueness: {scope: [:style, :gender], message: ", Style, and Gender combination already exists!"}

end
