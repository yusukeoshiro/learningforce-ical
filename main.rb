require 'sinatra'
require 'json'
require 'icalendar'
require 'time'
require 'pp'

get '/' do
	return 'ics file generator'
end

post '/' do
	# deserialize event
		event = JSON.parse(params["event"])

		pp event
	
	# create new ical object
		# Create a calendar with an event (standard method)
		cal = Icalendar::Calendar.new
		cal.event do |e|
			p event["From1__c"]
			p Time.parse( event["From1__c"] ).to_datetime
			e.dtstart     = Time.parse( event["From3__c"] ).to_datetime
			e.dtend       = Time.parse( event["To3__c"] ).to_datetime
			e.summary     = event["Name"]
			e.description = event["Description__c"]
			e.ip_class    = "PUBLIC"
			e.status      = "CONFIRMED"
			e.sequence    = 0
			e.priority    = 5
			e.transp      = "OPAQUE"
			e.attendee = Icalendar::Values::CalAddress.new("mailto:xxx@xxx.com", cn: '%%NAME%%')


		end

		#cal.publish
		cal.ip_method = "REQUEST"
		return cal.to_ical


end

