class IndicatorResource < ActiveRecord::Base

  # Relationships
  belongs_to :indicator
  belongs_to :resource

  # Validations
  validates_presence_of :indicator_id, :resource_id
  validates_numericality_of :indicator_id, only_integer: true
  validates_numericality_of :resource_id, only_integer: true

  # Methods
  def self.parse(spreadsheet, indicators, resources)
    indicator_resources_sheet = spreadsheet.sheet("Indicator_Resources")
    indicator_resources_hash = 
      indicator_resources_sheet.parse(indicator_id: "Indicator_ID", resource_id: "Resource_ID")

    indicator_resources = []
    indicator_resources_hash.each_with_index do |ir, index|
      indicator_resource = IndicatorResource.new

      # Used to set the foreign keys. 
      # indicator_id and resource_id should be the id of the indicator and resource
      # relative to the row number of indicator and resource sheets
      # the offset is because of 0 indexing plus the header in the excel file
      iid = ir[:indicator_id]
      # Check if the id is nil or if the id is out of bounds, if not then get the proper id
      ir[:indicator_id] = (iid.nil? || indicators[iid - 2].nil?) ? nil : indicators[iid - 2].id

      rid = ir[:resource_id]
      ir[:resource_id] = (rid.nil? || resources[rid - 2].nil?) ? nil : resources[rid - 2].id
      
      indicator_resource.attributes = ir.to_hash
      indicator_resources << indicator_resource
    end
    return indicator_resources
  end

end
