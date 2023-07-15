class ReceiptSerializer < ActiveModel::Serializer
  attributes :id, :receiver_type, :receiver_id, :mailbox_type, :is_read

  belongs_to :message
end
