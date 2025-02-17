class BoardRow < ApplicationRecord
  belongs_to :board
  has_many :board_cells
end