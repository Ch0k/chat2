class MessageSerializer < ActiveModel::Serializer
  attributes :id, :body, :subject, :sender_type, :sender_id, :conversation_id
end
