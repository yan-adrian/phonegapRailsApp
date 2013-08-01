class SendSMS
  include Sidekiq::Worker

  sidekiq_options queue: "high"
  sidekiq_options retry: true

  def perform(recepient, from, message)
  	nexmo = Nexmo::Client.new(API_KEY, API_SECRET)
    nexmo.send_message({
      :to => recepient,
      :from => from,
      :text =>  message
    })
  end
end