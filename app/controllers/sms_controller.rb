class SmsController < ApplicationController

  def new
  end

  def create
    api = Clickatell::API.authenticate('3415596', 'sbsfence','sbsfence123')
    api.send_message(params[:recipient], params[:message_text])
    flash[:notice] = "Message sent succesfully!"
    redirect_to :back
  rescue Clickatell::API::Error => e
    flash[:error] = "Clickatell API error: #{e.message}"
    redirect_to :back
  end
end