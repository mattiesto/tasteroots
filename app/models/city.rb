class City < ApplicationRecord
  # Direct associations

  has_many   :shops,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
