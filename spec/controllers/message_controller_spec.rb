require 'rails_helper'

describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:group) { create(:group) }
  let(:message) { create(:message) }
  describe 'GET#index' do

    context 'ログインしている場合' do
      before do
        login_user user
      end

      before :each do
        get :index, params: { group_id: group.id }
      end

      it "アクション内で定義したインスタンス変数(@message)があるか?" do
        message = Message.new
        get :index, params: { group_id: group.id }
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "アクション内で定義したインスタンス変数(@groups)があるか?" do
        groups = create_list(:group, 5, user_ids: user.id)
        expect(assigns(:groups)).to eq groups
      end

      it "アクション内で定義したインスタンス変数(@group)があるか?" do
        expect(assigns(:group)).to eq group
      end

      it "グループのメッセージ一覧の画面が表示されているか" do
        get :index, params: { group_id: group.id }
        expect(response).to render_template :index
      end
    end

    context 'ログインしていない場合' do
      it "ログイン画面にリダイレクトできているか?" do
        get :index, params: { group_id: group.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'POST#create' do

    context "ログインしているかつ、保存に成功した場合" do
      before do
        login_user user
      end

      it "メッセージの保存はできたのか?" do
        expect{ post :create, params: { message: attributes_for(:message, { body: 'hello' }), group_id: group.id }}.to change(Message, :count).by(1)
      end

      it "グループのメッセージ一覧の画面に遷移しているか?" do
        post :create, params: { group_id: group, message: attributes_for(:message)}
        expect(response).to redirect_to group_messages_path(group.id)
      end

      it "投稿成功時のフラッシュメッセージは表示されているか?" do
        post :create, params: { message: attributes_for(:message, { body: 'hello' }), group_id: group.id, user_id: user.id }
        expect(flash[:notice]).to include("メッセージ投稿が完了しました。")
      end
    end

    context "ログインしているが、保存に失敗した場合" do
      before do
        login_user user
      end

      it "メッセージの保存は行われなかったか?" do
        expect{ post :create, params: { message: attributes_for(:message, { body: nil, image: nil }), group_id: group.id, user_id: user.id }}.not_to change(Message, :count)
      end

      it "投稿失敗時のフラッシュメッセージは表示されているか?" do
        post :create, params: { message: attributes_for(:message, { body: nil, image: nil }), group_id: group.id, user_id: user.id }
        expect(flash[:alert]).to include("メッセージを入力してください。")
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトできているか?" do
        post :create, params: { group_id: group.id }
        expect(response).to redirect_to user_session_path
      end
    end
  end
end
