Tonermonkey::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[TONERMONKEY ERROR] ",
  :sender_address => APP_CONFIG[:email_support_from],
  :exception_recipients => [APP_CONFIG[:email_support_recipients].split(';')]
