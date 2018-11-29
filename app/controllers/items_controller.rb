class ItemsController < ApplicationController
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
  end

  def user_items
    current_user
    @items = @current_user.items.where(:is_deleted => false)
  end

  def search
    if params[:search].blank?
      @results = Item.all
    else
      @parameter = params[:search].downcase
      @results = Item.where("name LIKE ? OR description LIKE ?", "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").where(:is_deleted => false).where(:is_available => true)
    end
  end

  def remove
    item = Item.find(params[:id])
    item.is_deleted = true
    item.save
  end

  def borrow
    @item = Item.find(params[:id])

    if @item.is_available?
      @item.is_available = false
      @item.save

      flash.now[:success] = "Item successfully borrowed"
    else
      flash.now[:error] = "Item has already been borrowed"
    end

  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :deposit).merge(:is_available => true, :user_id => @user.id, :is_deleted => false)
  end

  def check_logged_in
    if session[:user_id]
      @user ||= User.find_by(id: session[:user_id])
    else
      redirect_to :controller => 'sessions', :action => 'new'
    end
  end
end
