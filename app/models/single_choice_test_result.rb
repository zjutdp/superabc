class SingleChoiceTestResult < ActiveRecord::Base
   # belongs_to + singular
   belongs_to :test_result, foreign_key: :tr_id
   belongs_to :single_choice, foreign_key: :sc_id
end


