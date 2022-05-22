if Rails.env == 'production'
  Rails.application.config.middleware.use ExceptionNotification::Rack,
                                          ignore_exceptions: ExceptionNotifier.ignored_exceptions,
                                          email: {
                                            email_prefix: 'PROD ERROR',
                                            sender_address: "warehouse_error@example.com",
                                            exception_recipients: %w{exceptions@example.com}
                                          }
end
