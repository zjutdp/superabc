class SingleChoiceTest < ActiveRecord::Base
   belongs_to :test, foreign_key: :t_id
   belongs_to :single_choice, foreign_key: :sc_id
end


