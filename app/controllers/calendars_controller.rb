class CalendarsController < ApplicationController
  def index
    if params[:date].present?
      @date = ArDate.parse(params[:date])
    else
      @date = ArDate.new
    end
  end
end
