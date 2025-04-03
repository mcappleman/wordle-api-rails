class Answer < ApplicationRecord
  validates :word, presence: true, uniqueness: true, length: { is: 5 }
  has_many :boards, dependent: :destroy

  def self.random_word
    # Select a random word from the list of words.
    self.order("RANDOM()").first
  end
end
