require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

desc "This task grabs the latest data from the BRSS Gorges site"
task :get_latest => :environment do
  get_latest_from_gorges  
end