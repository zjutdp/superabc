require 'csv'

class Word < ActiveRecord::Base

  validates :name, uniqueness: {case_sensitive: false, message: "English word should be unique"} 

  def self.generate_multi_choice
    words = Word.all.to_a
    done = 0

    while done < words.size do
      done += 1
      next if SingleChoice.exists?(:title => words[0])

      # remove the first word
      word = words.delete_at(0)
      # get itself and other 3 wrong choices
      choices = words.sample(3)
      choices = choices.push(word).shuffle

      sc = SingleChoice.new
      sc.title = word.name
      4.times do |n|
         sc.send('choice' + n.to_s + '=', choices[n].english_translation)
      end
      sc.answer = choices.find_index(word)
      sc.save

      # push back to the end of array
      words.push(word)
    end

  end

  def self.import_csv(file)

    path = file
    # "file"=>#<ActionDispatch::Http::UploadedFile:0x007f763e3d1fb0 @tempfile=#<Tempfile:/tmp/RackMultipart20160628-75110-lx0n74.csv>, @original_filename="words.csv" 
    # file is an uploaded http file stream
    if file.is_a? ActionDispatch::Http::UploadedFile
      path = file.path
    end

    import_result = []
    CSV.foreach(path) do |row|
      word = Word.new(:name => row[0], :english_translation => row[1])
      row.push word.save # keep saving result
      import_result.push(row)
    end

    import_result
  end

end
