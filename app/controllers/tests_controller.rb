class TestsController < ApplicationController

  def index
    @tests = Test.all
  end

  def new
    @single_choices = SingleChoice.all
    @listen_completes = ListenComplete.all
    @sorts = Sort.all
  end

  def single_choice
    if request.delete?
      SingleChoiceTest.delete_all(:sc_id => params[:sc_id], :t_id => params[:test_id])  # TODO test_id should be sct_id
    end

    redirect_to '/tests/' + params[:id]
  end

  def listen_complete
    if request.delete?
      ListenCompleteTest.delete_all(:lc_id => params[:lc_id], :t_id => params[:test_id])
    end

    redirect_to '/tests/' + params[:id]
  end

  def show
    @test = Test.find(params[:id])
  end

  def create
    @test_params = params[:test]
    
    Test.transaction do
      # save single choice tests
      test = Test.new(params.require(:test).permit(:name))

      if not params[:test][:single_choices].nil?
        params[:test][:single_choices].each do |sc|
          if sc[1] == "1"
            sc_record = SingleChoice.find(sc[0].to_i)
            test.single_choices.push(sc_record)
          end
        end
      end

      # save listen completes tests
      if not params[:test][:listen_completes].nil?
        params[:test][:listen_completes].each do |lc|
          if lc[1] == "1"
            lc_record = ListenComplete.find(lc[0].to_i)
            test.listen_completes.push(lc_record)
          end
        end
      end

      # save sorts tests
      if not params[:test][:sorts].nil?
        params[:test][:sorts].each do |s|
          if s[1] == "1"
            s_record = Sort.find(s[0].to_i)
            test.sorts.push(s_record)
          end
        end
      end

      test.save!
    end

    redirect_to action: 'index'
  end

  def destroy
    test = Test.find(params[:id])
    test.destroy!
    redirect_to action: 'index'
  end

  def delete_all
    Test.destroy_all
    redirect_to action: 'index'
  end

  def run
    @test = Test.find(params[:test_id])
    # Load current context
    # @test.single_choice_tests
    # @test.listen_complete_tests
    # @test.sorts
  end

  def result
    @test = Test.find(params[:test_id])
    @test_result = TestResult.new
    @test_result.test = @test 
    @test_result.name = @test.name + "@" + Time.now.to_s
    @test_result.start_at = Time.now
    @test_result.save
    @test.single_choice_tests.each do |sct|
      single_choice_test_result = SingleChoiceTestResult.new
      single_choice_test_result.test_result = @test_result
      single_choice_test_result.single_choice = sct.single_choice
      answer = params[:test][:answer][sct.single_choice.title]
      answer = answer.nil? ? SingleChoice::NOT_ANSWERED : answer.to_i #TODO 1st severe bug caused by nil.to_i is 0!!!!
      single_choice_test_result.answer = answer
      single_choice_test_result.save
    end

    @test.listen_complete_tests.each do |lct|
      listen_complete_test_result = ListenCompleteTestResult.new
      listen_complete_test_result.test_result = @test_result
      listen_complete_test_result.listen_complete = lct.listen_complete
      answer = params["listen_complete_#{lct.listen_complete.id}_#{lct.listen_complete.page}"] # answer sample: {"0"=>"1111", "1"=>"2222222"}
      listen_complete_test_result.answer = answer.to_json if not answer.nil?
      listen_complete_test_result.save
    end

    logger.debug "==============#{params}====================="

    render '/test_results/show'
  end

end
