class Question < ActiveRecord::Base
  # Relationships
  has_many :indicator_questions, :dependent => :destroy
  has_many :indicators, through: :indicator_questions

  # Validations
  validates_presence_of :question

  # Scopes
  scope :active, -> { where("active = ?", true) }
  scope :inactive, -> { where("active = ?",false) }
  scope :alphabetical, -> { order("question") }
  scope :for_indicator, -> (indicator_id) {joins(:indicators).where("indicators.id = ?",indicator_id).group("question")}
  scope :for_competency, -> (competency_id) {
    joins(:indicators).where("indicators.competency_id = ?", competency_id).group("question")
  }

  # Methods
  def self.parse(spreadsheet)
    questions_sheet = spreadsheet.sheet("Questions")
    questions_hash =
      questions_sheet.parse(question: "Question")

    questions = []
    questions_hash.each_with_index do |q, index|
      question = Question.new
      question.attributes = q.to_hash
      questions << question
    end
    return questions
  end

end
