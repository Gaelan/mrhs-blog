class Role < ActiveRecord::Base
  NAMES = %i( admin teacher mentor student ) # equivelent to [:admin, :teacher, ...]
  belongs_to :user
  enum role: NAMES
end
