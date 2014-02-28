task :environment do
  ENV["OKCUPID_ENV"] ||= "development"
  require_relative './config/environment'
end

namespace :db do
  task :migrate => :environment do

    # Rake task for getting all of the information out of the database
    Dir[File.join(File.dirname(__FILE__), "db/migrations", "*.rb")].each do |f| 
      require f
      migration = Kernel.const_get(f.split("/").last.split(".rb").first.gsub(/\d+/, "").split("_").collect{|w| w.strip.capitalize}.join())
      migration.migrate(:up)
    end
  end

  task :reset => :environment do 
    DB.tables.each do |table|
      DB.execute("DROP TABLE #{table}")
    end
  end
end

task :console => "db:migrate" do
  Pry.start
end









