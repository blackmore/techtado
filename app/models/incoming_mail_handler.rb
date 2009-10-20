class IncomingMailHandler < ActionMailer::Base
  
  def receive(message)
    begin
      ENV['RAILS_ENV'] = "production"
      # Creates a mms2r object to help clean up unwanted data
      mms = MMS2R::Media.new(message)
      
      Task.create_from_mail(message, mms)
    rescue StandardError, Interrupt
      puts $!, $@
    end
  end
end
