class Notification < ApplicationRecord

  #Method to send a notificcation to a user
  def self.fwd(dest:, msg:)
    Notification.create(user_to_id: dest, message: msg, has_seen: false)
  end

end
