require 'super_helper'

class SortTestResult < ActiveRecord::Base
   # belongs_to + singular
   belongs_to :test_result, foreign_key: :tr_id
   belongs_to :sort, foreign_key: :st_id

   def answer_array
     SuperHelper.indexed_h_to_a self.answer
   end

   def sort_test
     # test result and test has same "st_id"
     self.test_result.test.sort_tests.select {|x| x.st_id == self.st_id}[0]
   end
end

