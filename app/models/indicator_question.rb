class IndicatorQuestion < ActiveRecord::Base

  # Relationships
  belongs_to :indicator
  belongs_to :question

  # Validations
  validates_presence_of :indicator_id, :question_id
  validates_numericality_of :indicator_id, only_integer: true
  validates_numericality_of :question_id, only_integer: true

  # Methods
  def self.parse(spreadsheet, indicators, questions)
    indicator_questions_sheet = spreadsheet.sheet("Indicator_Questions")
    indicator_questions_hash =
      indicator_questions_sheet.parse(indicator_id: "Indicator_ID", question_id: "Question_ID")

    indicator_questions = []
    indicator_questions_hash.each_with_index do |iq, index|
      indicator_question = IndicatorQuestion.new

      # Used to set the foreign keys.
      # indicator_id and question_id should be the id of the indicator and question
      # relative to the row number of indicator and question sheets
      # the offset is because of 0 indexing plus the header in the excel file
      iid = iq[:indicator_id]
      # Check if the id is nil or if the id is out of bounds, if not then get the proper id
      iq[:indicator_id] = (iid.nil? || indicators[iid - 2].nil?) ? nil : indicators[iid - 2].id

      qid = iq[:question_id]
      iq[:question_id] = (qid.nil? || questions[qid - 2].nil?) ? nil : questions[qid - 2].id

      indicator_question.attributes = iq.to_hash
      indicator_questions << indicator_question
    end
    return indicator_questions
  end

end
