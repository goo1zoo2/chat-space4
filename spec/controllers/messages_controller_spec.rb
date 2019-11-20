require 'rails_helper'

describe MessagesController do
  #letを利用してテスト中使用するインスタンスを定義
  let(:group) { create(:group)} #letは呼び出された際に初めて実行される、遅延評価を持っている。複数のexampleで同一のインスタンスを使いたい時にletを利用する。
  let(:user){ create(:user) }

  describe '#index' do

    context 'log in' do
#ログインしている場合のテストを記述
      before do
        #beforeの内部に記述した処理は、各exampleが実行する直前で、毎回実行される。
        #今回は「ログインをする」、「擬似的にindexアクションを動かすリクエストを行う」が共通となるため、beforeの内部に記述。
        login user
        get :index, params: { group_id: group.id } 
          #擬似的にindexアクションを動かすリクエストを行うためget。
          #messagesのルーティングは、groupsにネストされているため、group_idを含んだパスを生成し、getメソッドの引数として、params:{group_id: group.id}を渡している。
      end

      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message) 
          #インスタンス変数に代入されたオブジェクトは、コントローラーのassigns経由で参照。
          #@messageを参照したい場合、assigns(:message)と記述。
          #@messageはMessage.newで定義された新しいMessageクラスのインスタンス。
          #be_a_newマッチャを利用することで、対象が引数で指定したクラスのインスタンスかつ未保存のレコードであるかどうかを確かめることができる。今回は、assigns(:message)がMessageクラスのインスタンスかつ未保存かどうかをチェックしている。
      end

      it 'assigns @group' do
        expect(assigns(:group)).to eq group #@groupはeqマッチャを利用して、assigns(:group)とgroupが同一であることを確かめることができるテスト。
      end

      #該当するビューが描画されているかどうかのテスト
      it 'renders index' do
        expect(response).to render_template :index
          #responseは、example内でリクエストが行われた後の遷移先のビューの情報を持つインスタンス。
          #render_templeteマッチャで引数にアクション名をとり、引数で指定されたアクションがリクエストされた時に自動的に遷移するビューを返す。
      end
    end


  context 'not log in' do
#ログインしていない場合のテストを記述
      before do
        get :index, params: { group_id: group.id }
      end

      #ログインしていない時に、意図したビューにリダイレクトできるかをテスト
      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
          #redirect_toマッチャは引数にとったプレフィックスにリダイレクトした際の情報を返すマッチャ。
          #今回は、非ログイン時にmessagesコントローラのindexアクションを動かすリクエストが行われた際に、ログイン画面にリダイレクトするかどうかを確かめる記述。
      end
    end
  end
end