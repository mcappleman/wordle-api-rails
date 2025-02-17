class Guess < ApplicationRecord
  validates :word, presence: true, length: { is: 5 }
end
