require 'time_arrange'


desc "Clean up the time string format"
task :create_pharmacies_openings => :environment do
  include MyModule
  
  pharmacies = Pharmacy.all
  pharmacies.each do |pharmacy|    
    
    time_format = parse_opening_hours(pharmacy.opening_hours)
    pharmacy.build_opening_time(Mon: time_format['Mon'], 
                                Tue: time_format['Tue'],
                                Wed: time_format['Wed'],
                                Thur: time_format['Thur'],
                                Fri: time_format['Fri'],
                                Sat: time_format['Sat'],
                                Sun: time_format['Sun']
                                )
    pharmacy.save
  end

end
