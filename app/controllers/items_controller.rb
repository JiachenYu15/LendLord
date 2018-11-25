class ItemsController < ApplicationController
  def index
    @items = Item.all
    #@items = Item.where(:is_deleted => false).all
  end

  def new
    @item = Item.new
  end

  def create
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
    @item = Item.find(params[:id])
  end

  def update
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
    @user = User.find(params[:id])
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

  private
  def item_params
    params.require(:item).permit(:name, :description, :deposit).merge(:is_available => true, :user_id => 1, :is_deleted => false)
  end
end
