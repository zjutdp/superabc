class SoundFilesController < ApplicationController

  def index
    @files = SoundFile.all
  end

  def show
    @file = SoundFile.find(params[:id])
  end

  def new
    if request.post?
      sound_files_album = params[:sound_files_album]

      params[:sound_files].each do |file|
        @file_record = SoundFile.new
        @file_record.name = (sound_files_album.blank? ? "" : sound_files_album + " - ") + file.original_filename
        @file_record.location = File.join(Rails.root, SoundFile::Location, @file_record.name)

        # save the file stream to the file location
        file_data = file.tempfile.read.force_encoding('ISO-8859-1')
        File.open(@file_record.location, "w:ISO-8859-1") { |f| f.write(file_data) }

        @file_record.save
      end

      redirect_to action: 'index'
    end
  end

  def destroy
    sf = SoundFile.find(params[:id])
    sf.destroy!
    redirect_to action: 'index'
  end

  def delete_all
    SoundFile.destroy_all
    redirect_to action: 'index'
  end

end
