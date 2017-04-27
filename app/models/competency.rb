class Competency < ActiveRecord::Base
  # Callback
  before_destroy :destroy_all

  # Relationships
  has_many :indicators

  # Validations
  validates_presence_of :name
  validates_presence_of :description


  # Scopes
  scope :alphabetical, -> { order("competencies.name") }
  scope :active, -> { where("competencies.active = ?", true) }
  scope :inactive, -> { where("competencies.active = ?", false) }


  # Methods
  def self.parse(spreadsheet)
    competencies_sheet = spreadsheet.sheet("Competencies")
    competencies_hash =
      competencies_sheet.parse(name: "Name", description: "Description")

    competencies = []
    competencies_hash.each_with_index do |c, index|
      competency = Competency.new
      competency.attributes = c.to_hash
      competencies << competency
    end
    return competencies
  end

  # Loop through indicator, questions, resources, and the many_to_many tables
  # and delete them all
  def destroy_all
    self.indicators.each do |i|
      i.resources.each(&:destroy)
      i.questions.each(&:destroy)
      i.indicator_questions.each(&:destroy)
      i.indicator_resources.each(&:destroy)
      i.destroy
    end
  end

end
