PIDFILE = Rails.root.to_s + "/log/websocket_worker.rb.pid"
namespace :websocket do
  desc "start websocket worker"
  task :start => :environment do
    sh "#{Rails.root.to_s}/lib/websocket_server.rb #{PIDFILE}"
    puts "websocket worker started."
  end

  desc "stop websocket worker"
  task :stop => :environment do
    if File.exist?(PIDFILE)
      pid = File.open(PIDFILE).read.chomp.to_i
      Process.kill :KILL, pid
      puts "websocket worker stoped."
    else
      puts "websocket worker not run."
    end
  end

  desc "restart websocket worker"
  task :restart => :environment do
    Rake::Task["websocket:stop"].invoke
    sleep(5)
    Rake::Task["websocket:start"].invoke
  end
end
