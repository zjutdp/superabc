class ListenComplete < ActiveRecord::Base

   SEP_BEFORE = "[["
   SEP_AFTER = "]]"
   SEP_REGEX = /(?<=\[\[)[^\[\]]*(?=\]\])/

   has_many :listen_complete_tests, foreign_key: :lc_id
   has_many :listen_complete_test_results, foreign_key: :lc_id

   belongs_to :sound_file, foreign_key: :sf_id

   validates :page, uniqueness: {scope: :story, message: "Page number must be unique in one story!"}

   before_destroy { |record| 
     ListenCompleteTest.destroy_all "lc_id = #{record.id}"
     ListenCompleteTestResult.destroy_all "lc_id = #{record.id}" 
   }

   def audio_player_id
     "audio_player_#{self.id}_#{self.sound_file.id}_#{self.page}"
   end

   def passage_html
     html = ""
     start_index = end_index = 0
     answers = self.passage.scan SEP_REGEX
     answers.each_with_index do |answer, index|
       answer_w_sep = "[[#{answer}]]"
       end_index = self.passage.index(answer_w_sep, start_index)
       # skip case: [[1st answer]] is the leading word of the passage
       html += self.passage[start_index..end_index-1] if not start_index == end_index
       html += "<textarea name='listen_complete_#{self.id}_#{self.page}[#{index}]' class='listen_complete_passage_textarea'></textarea>"
       start_index = end_index + answer_w_sep.size
     end

     html += self.passage[(end_index+answers.last.size+4)..self.passage.size-1] if not answers.empty?

     html.gsub("\r\n", "</br>")
   end

   def answer_array
     self.passage.scan SEP_REGEX
   end
end
