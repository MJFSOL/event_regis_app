class EventsController < ApplicationController
  # CREATING A EVENT
  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new(event_params)
    if @event.save
      redirect_to @event, notice: "Event is Created"
    else
      render :new, status: :unprocessable_entity, noice: "Please Fill up the forms"
    end
  end

  def show
    @event = Event.find(params[:id])
    @registration = @event.registrations.new
    @registrations = @event.registrations
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
     @event = Event.find(params[:id])
    if @event.update(event_params)
      # This redirect happens after the form is successfully submitted.
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to user_dashboard_page_path, notice: "Event was successfully deleted."
  end

  private

  def event_params
    params.required(:event).permit(:event_name, :date, :location, :description)
  end
end
