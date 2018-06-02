class SortsController < ApplicationController
  def new
    @sort = Sort.new
  end

  def create
    sort_record = Sort.new params.require(:sort).permit(:title, :content)
    sort_record.save

    redirect_to action: "index"
  end

  def edit
    @sort = Sort.find(params[:id])
  end

  def update
    sort = Sort.find(params[:id])
    sort.update_attributes params.require(:sort).permit(:title, :content)
    sort.save

    redirect_to action: 'index'
  end

  def index
    @sorts = Sort.all
  end

  def run
    @sort = Sort.find params[:sort_id]

    if request.post?
      result = @sort.check_answer params[:answers]
      logger.debug result
    end
  end

  def destroy
    s = Sort.find(params[:id])
    s.destroy!
    redirect_to action: 'index'    
  end
end
