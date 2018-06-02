class SuperHelper
  # "sortee: 0"=>"aa", "sortee: 1"=>"bbb", "sortee: 2"=>"ccd", "sortee: 3"=>"ddd", "sortee: 4"=>"", "sortee: 5"=>"", "sortee: 6"=>"", "sortee: 7"=>""}
  def self.indexed_h_to_a hash_str
     answer_hash = JSON.parse hash_str
     answers = Array.new answer_hash.size
     answer_hash.each do |key, value|
       answers[key.to_i] = value.strip
     end
     answers
  end
end
