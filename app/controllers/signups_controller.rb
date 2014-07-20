class SignupsController < ApplicationController
  include ActionController::MimeResponds

  def new
    puts params.inspect
    begin
      @signup ||= Signup.new
    rescue Exceptions::StdError => e
      @signup = Signup.new
    end
    respond_to do |format|
      format.html { render haml: @signup }
      format.json { render json: @signup }
    end
  end

  def create
    puts params.inspect
    begin
      @signup ||= Signup.new
      @signup.update(params)
      @user = @signup.save!
      route!
      respond_to do |format|
        format.html { render haml: @route }
        format.json { render json: @route }
      end
    rescue Exceptions::StdError => e
      :new
    end
  end
end