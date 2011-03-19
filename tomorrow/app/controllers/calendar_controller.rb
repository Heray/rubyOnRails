require "cgi"

class CalendarController < ApplicationController

  def initialize
    super
    @user = User.where(:id=>1)
  end

  def index
    @calendar = Event.all
  end

  def profile
    today = "2010-01-01"
    tomorrow = "2020-01-02"
    @events = Event.all
    @event = Event.new


    # start getting today's events
    today_events = Event.where("start_time >= :td AND start_time < :tm", {:td=>today,:tm=>tomorrow})

    @slot_names = \
    ['12am','12:30am','1am','1:30am','2am','2:30am','3am','3:30am',\
    '4am','4:30am','5am','5:30am','6am','6:30am','7am','7:30am',\
    '8am','8:30am','9am','9:30am','10am','10:30am','11am','11:30am',\
    '12pm','12:30pm','1pm','1:30pm','2pm','2:30pm','3pm','3:30pm',\
    '4pm','4:30pm','5pm','5:30pm','6pm','6:30pm','7pm','7:30pm',\
    '8pm','8:30pm','9pm','9:30pm','10pm','10:30pm','11pm','11:30pm']

    @slots_dic = {}

    @slots = []
    for i in 0..(@slot_names.length-1)
        @slots.push([])
    end

    today_events.each do |te|
        min = te['start_time'].min
    	hr = te['start_time'].hour

	# find the right index of this start time
	k = hr * 2
	if (min >= 30)
	   k += 1
	end

	@slots[k].push(te)

    end
    puts @slots

    # finish getting today's events


    starttime = "2011-01-03"
    endtime = "2011-01-03"

    @filtered_events = Event.where("start_time > :et OR end_time < :st",{:et=>endtime, :st=>starttime})

    @filtered_events = Event.where("start_time > :et OR end_time <:st",{:et=>"2010-01-01", :st=>"2010-01-01"})

  end

  def filter_events
    starttime = "2010-01-03"
    endtime = "2010-01-03"

    @filtered_events = Event.where("start_time > :et OR end_time < :st",{:et=>endtime, :st=>starttime})
    @filter_event_str = open("app/views/calendar/_temp.html.erb").read.gsub("\n"," ")

    render 'calendar/filtered_events.js.erb'

  end


  def add_event
    puts params
    tt = params['title']
    st = params['start_time']
    et = params['end_time']
    #@user.event.create(:title=>tt,:start_time=>st,:end_time=>et)
    ne = Event.new(:title=>tt,:start_time=>st,:end_time=>et, :u_id=>@user)
    ne.save

    render :text => "OK"
  end

end
