class SingleChoice < ActiveRecord::Base
   # answer is the index of the choice, namely 0, 1, 2, 3
   NOT_ANSWERED = -1

   has_many :single_choice_tests, foreign_key: :sc_id
   has_many :tests, through: :single_choice_tests

   validates :title, uniqueness: {case_sensitive: false, message: "Single choice question should be unique!"}

   before_destroy { |record| SingleChoiceTest.destroy_all "sc_id = #{record.id}" }
end
