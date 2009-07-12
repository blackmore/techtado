RAILS_ROOT = File.dirname(File.dirname(__FILE__))

God.watch do |w|
  w.name = "get_mail-fetcher"
  w.interval = 60.seconds
  w.start = "#{RAILS_ROOT}/script/mailer_daemon_fetcher start"
  w.stop = "#{RAILS_ROOT}/script/mailer_daemon_fetcher stop"
  w.start_grace = 20.seconds
  w.pid_file = "#{RAILS_ROOT}/log/MailerDaemonFetcherDaemon.pid"
  
  w.behavior(:clean_pid_file)
  
  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 10.seconds
      c.running = false
    end
  end
  
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end