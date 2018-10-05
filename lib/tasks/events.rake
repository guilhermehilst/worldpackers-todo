namespace :events do
  desc "Export All Events to CSV"

  task export: :environment do
    puts 'Starting to export Events'
    time_stamp = Time.now.strftime('%Y%m%dT%H%M')
    file_name = "tmp/exported_events_#{time_stamp}.csv"

    csv_data = Event.to_csv
    File.write(file_name, csv_data)

    puts 'export is completed'
    puts "see file: #{file_name}"
  end
end
