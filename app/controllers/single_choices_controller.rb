class SingleChoicesController < ApplicationController
  def index
    @single_choices = SingleChoice.all
  end

  def new
    if request.post?
      sc = SingleChoice.new(params.require(:single_choice).permit(:title, :choice0, :choice1, :choice2, :choice3, :answer))
      sc.save

      redirect_to action: 'index'
    end
  end

  def delete_all
    SingleChoice.destroy_all
    redirect_to action: 'index'
  end

  def destroy
    sc = SingleChoice.find(params[:id])
    sc.destroy!
    redirect_to action: 'index'
  end

end
