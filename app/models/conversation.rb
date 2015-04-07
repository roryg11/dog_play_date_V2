class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: "User"
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: "User"

  has_many :messages, dependent: :destroy

  scope :between, -> (sender_id, recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end

  def unread_messages_count(user_id)
    if messages.exists?
    @unread_messages = []
      messages.each do |message|
        if message.user_id != user_id
          if message.read == false
            @unread_messages << message
          end
        end
      end
    end
    @unread_messages.length
  end
  
end
