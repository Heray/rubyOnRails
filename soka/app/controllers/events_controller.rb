class EventsController < ApplicationController
  # GET /events
  def index
    @events = Events.all
  end

  def new
    @event = Events.new
  end

  def show
  end

  def create_event
    puts params
    puts "OKOKOKOK"
    render :text=>"OKOK"
  end
end
