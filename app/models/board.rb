class Board < ApplicationRecord
  has_one :wordle
  has_one :answer
end
