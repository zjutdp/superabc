class Sort < ActiveRecord::Base
   has_many :sort_tests, foreign_key: :st_id
   has_many :sort_test_results, foreign_key: :st_id

   validates :title, uniqueness: {message: "Sorting title must be unique in one story!"}
   validates :content, uniqueness: {message: "Sorting content must be unique in one story!"}

   before_destroy { |record| 
     SortTest.destroy_all "st_id = #{record.id}"
     SortTestResult.destroy_all "st_id = #{record.id}" 
   }

  def sortees
    content.scan /[^\r\n]+\r\n/
  end

  # {"谁谓河广？"=>[0, 4], "一苇杭之。"=>[1], "谁谓宋远？"=>[2, 6], "跂予望之。"=>[3], "曾不容刀。"=>[5], "曾不崇朝。"=>[7]}
  def answers_hash
    s_hash = {}
    s = self.sortees
    s.each_with_index do |sortee, index|
      sortee.strip!
      if s_hash.key? sortee
        s_hash[sortee].append index
      else
        s_hash[sortee] = [index]
      end
    end
    s_hash
  end

  # i_a_h is like {"7"=>"0", "0"=>"6", "5"=>"2", "2"=>"4", "3"=>"5", "1"=>"7", "4" => "1", "6" => "3"}
  def check_answer i_a_h
    s = self.sortees
    result = []
    a_h = self.answers_hash
    i_a_h.each do |key, value|
      result.push a_h[s[key.to_i].strip].include?(value.to_i)
    end

    result
  end
end
