module Api
  module V1
    class ConversationsController < Api::V1::BaseController
      before_action :check_current_subject_in_conversation, only: %i[show update destroy]
      before_action :get_mailbox, only: %i[inbox sentbox trash show index]

      def index
        @conversations = @mailbox.conversations
        render json: @conversations, status: :ok
      end

      def show
        @receipts = @mailbox.receipts_for(@conversation).not_trash
        @receipts.mark_as_read
        render json: @receipts, status: :ok
      end

      def inbox
        @conversations = @mailbox.inbox
        render json: @conversations, status: :ok
      end

      def sentbox
        @conversations= @mailbox.sentbox
        render json: @conversations, status: :ok
      end

      def trash
        @conversations = @mailbox.trash
        render json: @conversations, status: :ok
      end

      def update
        if params[:untrash].present?
          @conversation.untrash(current_user)
        end
    
        if params[:reply_all].present?
          last_receipt = @mailbox.receipts_for(@conversation).last
          @receipt = current_user.reply_to_all(last_receipt, params[:body])
        end
    
        #if @box.eql? 'trash'
          #@receipts = @mailbox.receipts_for(@conversation).trash
        #else
          @receipts = @mailbox.receipts_for(@conversation).not_trash
        #end
        @receipts.mark_as_read
      end

      def destroy
        @conversation.move_to_trash(current_user)
      end

      def create
        @recipients = 
          if params[:_recipients].present?
            @recipients = params[:_recipients].split(',').map{ |r| User.find_by(email: r) }
          else
            []
          end
        @receipt = current_user.send_message(@recipients, params[:body], params[:subject])
        if (@receipt.errors.blank?)
          @conversation = @receipt.conversation
          render json: @conversation, status: :ok
        else
          render json: { errors: "Error with messaage" }
        end
      end

      private

      def get_mailbox
        @mailbox = current_user.mailbox
      end

      def check_current_subject_in_conversation
        @conversation = Mailboxer::Conversation.find(params[:id])
    
        if @conversation.nil? or !@conversation.is_participant?(current_user)
          render json: { errors: "Not participant" }
        end
      end
    end
  end
end