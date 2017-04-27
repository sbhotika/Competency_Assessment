class Indicator < ActiveRecord::Base
  # Callbacks
  before_destroy :destroy_danglers

  # Relationships
  belongs_to :competency
  belongs_to :level

  has_many :resources, through: :indicator_resources
  has_many :questions, through: :indicator_questions
  has_many :indicator_questions
  has_many :indicator_resources

  # Validations
  validates_presence_of :competency_id, :level_id, :description
  validates_numericality_of :competency_id, only_integer: true
  validates_numericality_of :level_id, only_integer: true

  # Scopes
  scope :alphabetical, -> { order("indicators.description") }
  scope :by_level, -> { joins(:level).order("levels.ranking") }
  scope :by_competency, -> { joins(:competency).order("competencies.name") }
  scope :for_level, -> (level) { joins(:level).where("levels.name LIKE ?", level) }
  scope :for_description, -> (desc) { where("indicators.description LIKE ?", desc) }
  scope :for_competency, -> (competency) { joins(:competency).where("competencies.name LIKE ?", competency) }
  scope :for_question, -> (question) {joins(:indicator_questions).where("indicator_questions.question_id = ? ",question)}
  scope :for_resource, -> (resource) { joins(:indicator_resources).where("indicator_resources.resource_id = ?",resource) }
  scope :active, -> { where("indicators.active = ?", true) }
  scope :inactive, -> { where("indicators.active = ?", false) }


  # Methods
  def self.parse(spreadsheet, competencies, levels)
    indicators_sheet = spreadsheet.sheet("Indicators")
    indicators_hash =
      indicators_sheet.parse(level_id: "Level_ID", description: "Description")

    indicators = []
    indicators_hash.each_with_index do |i, index|
      indicator = Indicator.new

      # Used to set the foreign keys.
      # competency_id is always set to the first competency, since there's only 1 competency per spreadsheet
      i[:competency_id] = competencies[0].nil? ? nil : competencies[0].id

      # level_id should be the id of the level relative to the row number of levels
      # the offset is because of 0 indexing plus the header in the excel file
      lid = i[:level_id]
      # Check if the id is nil or if the id is out of bounds, if not then get the proper id
      i[:level_id] = (lid.nil? || levels[lid - 2].nil?) ? nil : levels[lid - 2].id

      indicator.attributes = i.to_hash
      indicators << indicator
    end
    return indicators
  end

  # Destroy questions and resources who are only tied to the indicator being destroyed
  def destroy_danglers
    self.questions.each do |q|
      if Indicator.for_question(q.id).count == 1
        q.destroy
      end
    end
    self.resources.each do |r|
      if Indicator.for_resource(r.id).count == 1
        r.destroy
      end
    end
  end

end
