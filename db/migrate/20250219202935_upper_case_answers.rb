class UpperCaseAnswers < ActiveRecord::Migration[8.0]
  def change
    answers = Answer.all
    answers.each do |answer|
      answer.update!(word: answer.word.upcase)
    end
  end
end
