require 'rails_helper'

describe Message, type: :model do 
    describe '#create' do
        context 'can be saved' do
            it 'is valid with content' do
                expect(build(:message, image: nil)).to be_valid
            end

            it 'is valid with image' do
                expect(build(:message, content: nil)).to be_valid
            end

            it 'is valid with content and image' do
                expect(build(:message)).to be_valid
            end
        end

        context 'cannot be saved' do
            it 'is valid without content and image' do
                @message = build(:message, image: nil, content: nil)
                @message.valid?
                expect(@message.errors[:content]).to include("can't be blank")
            end

            it 'is valid without user_id' do
                @message = build(:message, user_id: nil)
                @message.valid?
                expect(@message.errors[:user]).to include("must exist")
            end

            it 'is valid without group_id' do
                @message = build(:message, group_id: nil)
                @message.valid?
                expect(@message.errors[:group]).to include("must exist")
            end
        end
    end
end
