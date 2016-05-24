class API::EventsController < ApplicationController
   skip_before_action :verify_authenticity_token
   before_filter :set_access_control_headers

   def set_access_control_headers
     headers['Access-Control-Allow-Origin'] = '*'
     headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
     headers['Access-Control-Allow-Headers'] = 'Content-Type'
   end

   #rescue_from ActiveRecord::RecordNotFound, with: :not_found
   #rescue_from ActionController::ParameterMissing, with: :malformed_request

   def create
     registered_application = RegisteredApplication.find_by(url: request.env['HTTP_ORIGIN'])
     if registered_application == nil
       render json: "Unregistered application", status: :unprocessable_entity
     else
       @event = Event.new(event_params)
       @event.registered_application = registered_application

       if @event.valid?
         @event.save!
         render json: @event, status: :created
       else
         render json: {errors: @event.errors}, status: :unprocessable_entity
       end
     end

   end

   def preflight
    head 200
   end

   private

   def event_params
     params.require(:event).permit(:name)
   end

   def malformed_request
     render json: { error: "The request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications.", status: 400 }, status: 400
   end

   def not_found
     render json: { error: "Record not found", status: 404 }, status: 404
   end
 end
