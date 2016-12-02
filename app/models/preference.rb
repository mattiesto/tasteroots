class Preference < ApplicationRecord
  # Direct associations

  has_many   :routes,
             :dependent => :destroy

  has_many   :users,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
