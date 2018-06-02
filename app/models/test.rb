class Test < ActiveRecord::Base
  # Declare the direct relation (test->single_choice_tests) before indirect (test->single_choices) is required, see http://stackoverflow.com/questions/1781202/could-not-find-the-association-problem-in-rails
  has_many :single_choice_tests, foreign_key: :t_id
  has_many :single_choices, through: :single_choice_tests

  has_many :sort_tests, foreign_key: :t_id
  has_many :sorts, through: :sort_tests

  has_many :listen_complete_tests, foreign_key: :t_id
  has_many :listen_completes, through: :listen_complete_tests

  validates :name, presence: true, uniqueness: {case_sensitive: false, message: "Test name should be unique!"}

  before_destroy { |record| 
    SingleChoiceTest.destroy_all "t_id = #{record.id}"
    ListenCompleteTest.destroy_all "t_id = #{record.id}"
    TestResult.destroy_all "t_id = #{record.id}"
  }

  def desc
    "#{self.single_choice_tests.size} Single Choice(s), #{self.listen_complete_tests.size}  Listen and Complete(s), #{self.sorts.size} Sorts" 
  end

end

