class MessagesController < ApplicationController
    def index
        @message = Message.new
        @messages = []
        
        if params.has_key?(:group_id)
            @group = Group.find(params[:group_id])
            @messages = @group.messages.includes(:user)
        end

        respond_to do |format|
            format.html {}
            format.json {
                #byebug
                @new_message = @group.messages.where('id > ?', params[:message][:id])
                render json: json_messages_builder(@new_message)
            }
        end
    end

    def create
        @group = Group.find(params[:group_id])
        @message = @group.messages.new(message_params)
        
        if @message.save 
            respond_to do |format|
                format.html { redirect_to group_messages_path(@group), notice: "メッセージが送られました"}
                format.json { render json: json_messages_builder( [@message] ) }
            end
        else
            flash.now[:alert] = "メッセージを入力してください"
            render :index
        end
    end 

    private
        def json_messages_builder(messages)
            json = []
            messages.each do |message|
                json_message = {
                    id:         message.id,
                    content:    message.content, 
                    image:      message.image.to_s, 
                    created_at: message.created_at, 
                    user:       message.user.name,
                }
                json.push( json_message )
            end 
            json
        end

        def message_params 
            params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
        end
end
