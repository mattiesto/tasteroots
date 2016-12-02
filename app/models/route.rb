class Route < ApplicationRecord
  # Direct associations

  belongs_to :city

  belongs_to :preference

  # Indirect associations

  # Validations

end
