class ReportedGood < ApplicationRecord
  belongs_to :consignment
  belongs_to :report
  belongs_to :good    
end
