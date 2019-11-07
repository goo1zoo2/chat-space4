class MessagesController < ApplicationController

  
  def index
   

  end

  def create
    Message.create(name: "", image: "", text: "")
  end

end
