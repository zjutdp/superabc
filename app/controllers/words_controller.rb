class WordsController < ApplicationController

  def index
    @words = Word.all
  end

  def show
    @word = Word.find(params[:id])
  end

  def destroy
    Word.destroy params[:id] if Word.exists? (params[:id])

    redirect_to action: 'index'
  end

  def delete_all
    Word.destroy_all
    redirect_to '/welcome/index'
  end

  def create
    @word = Word.new(params.require(:word).permit(:name, :english_translation))
    @word.save

    redirect_to action: 'index'
  end

  def import
    if request.post?
      @import_result = Word.import_csv params[:file].tempfile
      render :import_result
    end
  end

  def generate_single_choice
    Word.generate_multi_choice

    redirect_to "/single_choices"
  end

end
