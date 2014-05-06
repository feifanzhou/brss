require 'json'
require 'open-uri'

module ApplicationHelper
  def save_login(user)
    return false if user.blank?
    cookies.permanent.signed[:user_remember] = user.remember_token
    return true
  end

  def current_user
    User.find_by_remember_token(cookies.signed[:user_remember])
  end

  def authenticate_provision
    auth_code = params[:auth_code]
    prov = Provision.find_by_code(auth_code)
    return head(:forbidden) if prov.blank? || prov.is_deleted
  end

  def get_latest_from_gorges(rep_name)
    puts '===== Getting Gorges data ====='
    @data = JSON.load(open("http://brss.gorges.us/mobile/get_contracts.php?username=#{ rep_name }&key=BRSS2013"))
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
      pickup_appt_id = -1
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
                 is_cancelled: false,
                 packaging_hours: appointment['packaging_hours'],
                 rep_name: rep_name
               )
        appt.rep_name = rep_name # Reassign
        appt.save
        pickup_appt_id = appt.id if appointment['type_text'] == 'pickup'
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
                 value: 100,
                 should_insure: false
               )
      end if !contract['boxes'].blank?
      contract['supplies'].each do |supply|
        s = Supply.find_by_supply_id(supply['supplyID'].to_i) || Supply.create(
              appointment_id: pickup_appt_id,
              description: supply['item'],
              count: supply['quantity'].to_i,
              supply_id: supply['supplyID'].to_i
            )
      end if !contract['supplies'].blank?
    end
    puts "Updated with data from Gorges database"
  end

  def get_all_from_gorges
    Provision.where('is_deleted=false').map(&:rep_name).each do |name|
      get_latest_from_gorges(name)
    end
  end
end
