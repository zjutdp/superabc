require 'super_helper'

class ListenCompleteTestResult < ActiveRecord::Base
   # belongs_to + singular
   belongs_to :test_result, foreign_key: :tr_id
   belongs_to :listen_complete, foreign_key: :lc_id

   def answer_array
     SuperHelper.indexed_h_to_a self.answer
   end
end

