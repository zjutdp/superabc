class SortTest < ActiveRecord::Base
   belongs_to :test, foreign_key: :t_id
   belongs_to :sort, foreign_key: :st_id

   # [[7, "曾不崇朝。\r\n"], [1, "一苇杭之。\r\n"], [2, "谁谓宋远？ \r\n"], [4, "谁谓河广？\r\n"], [3, "跂予望之。\r\n"], [0, "谁谓河广？ \r\n"], [6, "谁谓宋远？\r\n"], [5, "曾不容刀。\r\n"]]
   def sortee_array
     JSON.parse self.sortees
   end

   # {"曾不崇朝。\r\n"=>"3", "一苇杭之。\r\n"=>"1", ...}
   def answer_hash_to_sortee_array answer_hash
     sortees = Array.new(answer_hash.size)
     answer_hash.each do |key, value|
       sortees[value.to_i] = key
     end
     sortees
   end
end


