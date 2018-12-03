class ItemsController < ApplicationController

  include ItemsHelper

  def index
    @items = Item.all
    #@items = Item.where(:is_deleted => false).all
  end

  def new
    check_logged_in
    @item = Item.new
  end

  def create
    check_logged_in
    @item = Item.new(item_params)
    if @item.save
      # Successful save.
      flash[:success] = "Item successfully posted"
      redirect_to @item
    else
      render 'new'
    end
  end

  def edit
    check_logged_in
    @item = Item.find(params[:id])
  end

  def update
    check_logged_in
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      # Handle a successful update.
      flash[:success] = "Item successfully updated"
      redirect_to @item
    else
      render 'edit'
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = User.find(@item.user_id)
  end

  def user_items
    current_user
    @items = @current_user.items.where(:is_deleted => false)
  end

  def search
    allItems = Item.all

    # Make sure user doesn't search for their own items
    if logged_in?
      allItems = Item.where("user_id <> ?", "#{@current_user.id}")
    end

    if params[:search].blank?
      # Return all items if user does not input search parameters
      @results = allItems
    else
      # Search according to user input
      @parameter = params[:search].downcase
      @location = params[:location].downcase
      @results = allItems.where("lower(name) LIKE ? OR lower(description) LIKE ?", "%#{@parameter}%", "%#{@parameter}%").where(:is_deleted => false).where(:is_available => true)

      if(!@location.blank?)
        @results = @results.joins(:user).where("lower(address) LIKE ? OR address = '' OR ? = ''", "%#{@location}", "%#{@location}")
      end
    end
  end

  def remove
    item = Item.find(params[:id])
    item.is_deleted = true
    item.save
  end

  def borrow
    check_logged_in
    @item = Item.find(params[:id])
    if logged_in?
      return if create_paypal_payment?

      flash.now[:error] = 'Oops! Something wrong with PayPal, Please try again later.'
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :deposit, :image_link).merge(:is_available => true, :user_id => @user.id, :is_deleted => false)
  end

end
