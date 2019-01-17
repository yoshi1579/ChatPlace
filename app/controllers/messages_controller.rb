class MessagesController < ApplicationController
    def index
        @message = Message.new
        @messages = []
        if params.has_key?(:group_id)
            @group = Group.find(params[:group_id])
            @messages = @group.messages.includes(:user)
        end
    end

    def create
        @group = Group.find(params[:group_id])
        @message = @group.messages.new(message_params)
        if @message.save 
            redirect_to group_messages_path(@group), notice: "メッセージが送られました"
        else
            flash.now[:alert] = "メッセージを入力してください"
            render :index
        end
    end 

    private
        def message_params 
            params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
        end
end
