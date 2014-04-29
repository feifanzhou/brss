require 'json'
require 'open-uri'
desc "This task grabs the latest data from the BRSS Gorges site"
task :get_latest => :environment do
  puts '===== Getting Gorges data ====='
  @data = JSON.load(open('http://brss.gorges.us/mobile/get_contracts.php?username=jblow&key=BRSS2013'))
  # TODO: Update with new data if Gorges DB changes for existing entry
  @data.each do |contract|
    user = User.find_by_email(contract['email']) || User.create(
             fname: contract['firstname'], 
             lname: contract['lastname'], 
             email: contract['email'],
             phone: contract['phone'],
             address1: contract['address1'],
             address2: contract['address2'],
             city: contract['city'],
             state: contract['state'],
             zip: contract['zip']
           )
    ctrt = Contract.find_by_contract_id(contract['contractID']) || Contract.create(
             user_id: user.id, 
             contract_id: contract['contractID'].to_i,
             contract_type: contract['contract_type_text'],
             notes: contract['notes'],
             is_cancelled: false
           )
    contract['appointments'].each do |appointment|
      appt_date = nil
      begin
        appt_date = Date.parse(appointment['date'])
      rescue
        puts "Invalid appt date: #{ appointment['date'] }"
      end
      request_date = nil
      begin
        request_date = Date.parse(appointment['request_date'])
      rescue
        puts "Invalid request date: #{ appointment['request_date'] }"
      end
      # TODO: Use exists? rather than returning the whole object in find
      appt = Appointment.find_by_appointment_id(appointment['appointmentID']) || Appointment.create(
               contract_id: ctrt.id,
               appointment_id: appointment['appointmentID'].to_i,
               date: appt_date,
               insurance_cost: appointment['insurance_cost'].to_i,
               address: appointment['location'],
               notes: appointment['notes'],
               on_campus: appointment['on_campus'] != '0',
               request_date: request_date,
               status: appointment['status_text'],
               appointment_type: appointment['type_text'],
               timeslot_number: appointment['timeslot'].to_i,
               timeslot_text: appointment['timeslot_text'],
               is_cancelled: false
             )
    end if !contract['appointments'].blank?
    contract['boxes'].each do |box|
      # TODO: Use exists? rather than returning the whole object in find
      # TODO: Merge identical types into quantity rather than creating separate items
      item = Item.find_by_box_id(box['appID']) || Item.create(
               contract_id: ctrt.id,
               item_type: box['type_text'],
               description: box['details'],
               notes: box['notes'],
               weight: box['weight'].to_f,
               box_id: box['appID'],
               is_deleted: box['removed'] != '0',
               quantity: 1
             )
    end if !contract['boxes'].blank?
  end
  puts "Updated with data from Gorges database"
end