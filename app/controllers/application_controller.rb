class ApplicationController < ActionController::Base

    before_action :authenticate_user!, :except => [:show, :index]

    #include SessionHelper

    add_flash_types :danger, :info, :warning, :success

end
