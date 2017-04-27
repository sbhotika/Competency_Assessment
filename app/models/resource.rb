class Resource < ActiveRecord::Base

  # Callback Functions
  before_save :reformat_link

  # Relationships
  belongs_to :paradigm

  has_many :indicator_resources, :dependent => :destroy
  has_many :indicators, through: :indicator_resources

  # Validations
  validates_presence_of :title, :paradigm_id
  validates_numericality_of :paradigm_id, only_integer: true

  # Scopes
  scope :alphabetical, -> { order("title") }
  scope :active, -> { where('active = ?', true) }
  scope :inactive, -> { where('active = ?', false) }
  scope :for_indicator, -> (indicator_id) {joins(:indicators).where("indicators.id = ?",indicator_id).group("title")}

  # Methods
  def self.parse(spreadsheet, paradigms)
    resources_sheet = spreadsheet.sheet("Resources")
    resources_hash =
      resources_sheet.parse(paradigm_id: "Paradigm_ID", title: "Title/Resource", link: "Link")

    resources = []
    resources_hash.each_with_index do |r, index|
      resource = Resource.new

      # Used to set the foreign keys.
      # paradigm_id should be the id of the paradigm relative to the row number of paradigms
      # the offset is because of 0 indexing plus the header in the excel file
      pid = r[:paradigm_id]
      # Check if the id is nil or if the id is out of bounds, if not then get the proper id
      r[:paradigm_id] = (pid.nil? || paradigms[pid - 2].nil?) ? nil : paradigms[pid - 2].id

      resource.attributes = r.to_hash
      resources << resource
    end
    return resources
  end

  # Private Methods
  private
    # Ensure that all links are saved with 'http://'
    # so that rails doesn't think the external links are relative links
    def reformat_link
      reg = /^https?:\/\//
      link = self.link
      if link.present? && !link.match(reg)
        link.insert(0,"http://")
      end
      self.link = link
    end

end
