class TestResultsController < ApplicationController

  def index
    @test_results = TestResult.all
  end

  def show
    @test_result = TestResult.find(params[:id])
  end

  def destroy
    test_result = TestResult.find(params[:id])
    test_result.destroy!
    redirect_to action: 'index'
  end

end
