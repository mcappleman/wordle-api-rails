class BoardCell < ApplicationRecord
  belongs_to :board_row
  validates :char, presence: true, length: { is: 1 }
  validates :color, presence: true
end