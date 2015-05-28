class ModelMailer < ActionMailer::Base
  default from: "quincy@mailgun.org"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.model_mailer.new_record_notification.subject
  #
  def new_record_notification(first_name, recipient, movie)
    @first_name = first_name
    @movie = movie
    mail to: recipient, subject: "You've signed up for movie updates!"
  end

  def movie_available_email(first_name, recipient, movie)
    @first_name = first_name
    @movie = movie
    mail to: recipient, subject: "You're movie is availble on iTunes!!"
  end
end
