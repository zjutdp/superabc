class ListenCompleteTest < ActiveRecord::Base
   belongs_to :test, foreign_key: :t_id
   belongs_to :listen_complete, foreign_key: :lc_id
end


