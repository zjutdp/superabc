class TestResult < ActiveRecord::Base
  # Declare the direct relation (test->single_choice_tests) before indirect (test->single_choices) is required, see http://stackoverflow.com/questions/1781202/could-not-find-the-association-problem-in-rails
  has_many :listen_complete_test_results, foreign_key: :tr_id
  has_many :single_choice_test_results, foreign_key: :tr_id
  belongs_to :test, foreign_key: :t_id

  validates :name, uniqueness: {case_sensitive: false, message: "Test result name should be unique!"}

  before_destroy { |record| 
    SingleChoiceTestResult.destroy_all "tr_id = #{record.id}"
    ListenCompleteTestResult.destroy_all "tr_id = #{record.id}"
  }

  def result
    single_choice_corrects = listen_complete_corrects = 0
    self.single_choice_test_results.each do |sctr|
      single_choice_corrects += 1 if sctr.answer == sctr.single_choice.answer      
    end

    self.listen_complete_test_results.each do |lctr|
      # answer sample: {"0"=>"1111", "1"=>"2222222"}
      answer_hash = JSON.parse lctr.answer
      answer_array = lctr.listen_complete.answer_array
      answer_hash.each do |key, value|
        listen_complete_corrects += 1 if answer_array[key.to_i].strip == value.strip
      end
    end

    lc_answer_size = self.test.listen_complete_tests.map{ |lct| lct.listen_complete.answer_array.size }.inject(0) {|sum, x| sum + x}

    "Single Choice: #{single_choice_corrects}/#{self.test.single_choices.size};  Listen & Complete: #{listen_complete_corrects}/#{lc_answer_size}"
  end

end

