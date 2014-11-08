module MailerMacros
  def last_email
    ActionMailer::Base.deliveries.last
  end

  def reset_email
    ActionMailer::Base.deliveries = []
  end

  def all_emails
    ActionMailer::Base.deliveries
  end

  def all_emails_sent_count
    ActionMailer::Base.deliveries.count
  end
end
