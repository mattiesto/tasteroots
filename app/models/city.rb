class City < ApplicationRecord
  # Direct associations

  has_many   :routes,
             :dependent => :destroy

  has_many   :restaurants,
             :dependent => :destroy

  has_many   :shops,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
