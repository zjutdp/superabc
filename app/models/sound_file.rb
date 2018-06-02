class SoundFile < ActiveRecord::Base

  LocationDirName = "/soundfiles"
  Location = File.join("/public", LocationDirName)

  has_many :listen_completes, foreign_key: :sf_id

  validates :name, uniqueness: {case_sensitive: false, message: "Sound file name should be unique"} 

  before_destroy { |record| 
    File.delete(record.location) if File.exists? (record.location)
    ListenComplete.destroy_all "sf_id = #{record.id}"
  }
end
