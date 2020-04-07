class ItemsController<ApplicationController

  def index

    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @page = params[:page].to_i
      @page = 0 unless @page
      @items = Item.all.includes(:merchant).limit(50).offset(50 * @page)
      @top_five_ordered = Item.by_quantity_ordered("DESC")
      @bottom_five_ordered = Item.by_quantity_ordered("ASC")
      @top_five_reviewed = Item.by_average_rating("DESC")
      @bottom_five_reviewed = Item.by_average_rating("ASC")
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = @merchant.items.create(item_params)
    if item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:error] = item.errors.full_messages
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    if @item.save
      redirect_to "/items/#{@item.id}"
    else
      flash[:error] = @item.errors.full_messages
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    Review.where(item_id: item.id).destroy_all
    item.destroy
    redirect_to "/items"
  end

  private

  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end


end
