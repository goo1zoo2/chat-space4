class MessagesController < ApplicationController
  def index
    @message = "プログラミング"
  end

  def create
    Message.create(name: "", image: "", text: "")
  end
end
