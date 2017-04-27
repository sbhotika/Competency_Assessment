class Level < ActiveRecord::Base
  # Relationships
  has_many :indicators, :dependent => :destroy

  # Validations
  validates_presence_of :name, :description, :ranking
  # The lower the ranking the higher the level
  validates_numericality_of :ranking, only_integer: true
  validates_uniqueness_of :ranking, :name


  # Scopes
  scope :alphabetical, -> { order("levels.name") }
  scope :by_ranking, -> { order("levels.ranking") }
  scope :active, -> { where("levels.active = ?", true) }
  scope :inactive, -> { where("levels.active = ?", false) }


  # Methods
  def self.parse(spreadsheet)
    levels_sheet = spreadsheet.sheet("Levels")
    levels_hash =
      levels_sheet.parse(name: "Name", description: "Description", ranking: "Ranking")

    levels = []
    new_levels = []
    levels_hash.each_with_index do |l, index|
      # Checks if a Level of the same name exists
      # If it does, then set the level to the existing level instance
      # Else create a whole new level instance and add it to the
      # new_levels list in order to be saved later
      if Level.exists?(name: l[:name])
        level = Level.find_by_name(l[:name])
      else
        level = Level.new
        level.attributes = l.to_hash
        new_levels << level
      end
      levels << level
    end
    return levels, new_levels
  end

end
