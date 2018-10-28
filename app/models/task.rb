class Task < ApplicationRecord
  include RankedModel
  ranks :row_order
  validates :content,presence: true, length:{maximum:255}
  
end
