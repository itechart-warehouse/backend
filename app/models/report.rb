class Report < ApplicationRecord
  belongs_to :report_type
  belongs_to :consignment
end
