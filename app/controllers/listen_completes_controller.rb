class ListenCompletesController < ApplicationController
  helper_method :test_hm
  helper ListenCompletesHelper

  def test_helper_method 
    "test_helper_method_called"
  end

  def index
    @listen_completes = ListenComplete.all
  end

  def new
    @listen_complete = ListenComplete.new
    @sound_files = SoundFile.all
  end

  def create
    lc = ListenComplete.new(params.require(:listen_complete).permit(:story, :page, :passage, :sf_id, :playback_start, :playback_end))
    lc.save

    redirect_to action: 'index'
  end

  def edit
    @listen_complete = ListenComplete.find(params[:id])
    @sound_files = SoundFile.all   
  end

  def update
    lc = ListenComplete.find(params[:id])
    lc.update_attributes(params.require(:listen_complete).permit(:story, :page, :passage, :sf_id, :playback_start, :playback_end))
    lc.save

    redirect_to action: 'index'
  end

  def delete_all
    ListenComplete.destroy_all
    redirect_to action: 'index'
  end

  def destroy
    lc = ListenComplete.find(params[:id])
    lc.destroy!
    redirect_to action: 'index'
  end

end
