require 'rails_helper'

RSpec.describe Message, type: :model do
  describe '#create' do #テストする対象を表す
#メッセージを保存できる場合
    context 'can save' do #テストする時の状況を表す。特定の条件でテストをグループ分けしたい場合にcontextを使う。
# メッセージがあれば保存できる
      it 'is valid with content' do
        expect(build(:message, image: nil)).to be_valid #build(:message)でMessageモデルのインスタンスを生成。buildは、カラム名：値の形で引数を渡すことによって、ファクトリーで定義されたデフォルトの値を上書きすることができる。
      end
#画像があれば保存できる
      it 'is valid with image' do
        expect(build(:message, content: nil)).to be_valid
      end
#メッセージと画像があれば保存できる
      it 'is valid with content and image' do
        expect(build(:message)).to be_valid #build(:message)でメッセージと画像を持ったインスタンスを生成。
      end
    end
#メッセージを保存できない場合
    context 'can not save' do
#メッセージも画像もないと保存できない
      it 'is invalid without content and image' do
        message = build(:message, content: nil, image: nil)
        message.valid? #作成したインスタンスがバリデーションによって保存ができない状態かチェックするため、valid?を利用する。
        expect(message.errors[:content]).to include('を入力してください') 
          #valid?を利用したインス端子に対して、errorsを使用することによって、バリデーションにより保存ができない状態である場合なぜできないのかを確認することができる。
          #今回はcontent、imageがnilの場合は'を入力してください。'というエラーメッセージが含まれることがわかっているためincludeマッチャを用いる。
          #expectの引数に関して,message.errors[:カラム名]と記述することで、そのカラムが原因のエラー文が入った配列を取り出すことができる。これに対して、includeマッチャを利用してエクスペクテーションを作成。
      end
#group_idがないと保存できない
      it 'is invalid without group_id' do
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include('を入力してください')
      end
#user_idがないと保存できない
      it 'is invaid without user_id' do
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include('を入力してください')
      end
    end
  end
end