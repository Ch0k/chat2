module Api
  module V1
    class MessagesController < Api::V1::BaseController
      before_action :get_mailbox
      
      def create
        conversation = Mailboxer::Conversation.find(params[:conversation_id])
        body = params[:body]
        @message = current_user.reply_to_conversation(conversation, body)
        render json: @message, status: :created
      end

      def show
        @message = Mailboxer::Message.find(params[:id])
        @conversation = @message&.conversation
        if @message.present? && @conversation.present?
          if @conversation.is_participant?(current_user)
            render json: @message, status: :ok
          end
        end
      end

      private

      def get_mailbox
        @mailbox = current_user.mailbox
      end
    end
  end
end