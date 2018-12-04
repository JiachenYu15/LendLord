class ItemsController < ApplicationController

  include ItemsHelper

  def index
    item_ratings
    @items = Item.where(:is_deleted => false).where(:is_available => true)
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
    item_ratings
    @item = Item.find(params[:id])
    @owner = Person.find(@item.person_id)
    @user = current_user
    @transaction_state = params['transaction_state']
  end

  def user_items
    item_ratings
    @items = current_user.person.items.where(:is_deleted => false)
  end

  def search
    item_ratings

    # Make sure user doesn't search for their own items
    allItems = Item.where("person_id <> ?", "#{current_user.person.id}")

    if params[:search].blank?
      # Return all items if user does not input search parameters
      @results = allItems
    else
      # Search according to user input
      @parameter = params[:search].downcase
      @location = params[:location].downcase
      @results = allItems.where("lower(name) LIKE ? OR lower(description) LIKE ?", "%#{@parameter}%", "%#{@parameter}%").where(:is_deleted => false).where(:is_available => true)

      if(!@location.blank?)
        @results = @results.joins(:person).where("lower(city) LIKE ? OR ? = ''", "%#{@location}%", "%#{@location}%")
      end
    end
  end

  def remove
    item = Item.find(params[:id])
    item.is_deleted = true
    item.save
  end

  def borrow
    item_ratings

    @item = Item.find(params[:id])

    return if create_paypal_payment?

    flash.now[:error] = 'Oops! Something wrong with PayPal, Please try again later.'

  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :deposit, :image_link).merge(:is_available => true, :person_id => current_user.person.id, :is_deleted => false)
  end

  def item_ratings
    @itemRatings = Item.includes(transactions: :ratings).group(:id).average(:score)
  end
end
