class EventsController < ApplicationController
  def create
    @registered_application = RegisteredApplication.find(params[:registered_application_id])
    @url = @registered_application.url
    
    @event = @registered_application.events.new(event_params)

    if @event.save
      flash[:notice] = "New Event Update"
    else
      flash[:alert] = "No Event Update"
    end

    respond_to do |format|
       format.html
       format.js
     end
  end

  private

  def event_params
    params.require(:event).permit(:name)
  end
end
