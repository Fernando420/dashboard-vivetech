class OrdersController < ApplicationController

  def new
    @title = t('orders.new')
    @order = {}
  end

  def add_variant
    @variant_index = params[:product_index]
    @variant = {name: '', price: ''}
  end

  def add_product
    @product = {name: '', desciption: ''}
  end
  
  def index
    @title = t('orders.list')
    response = ApiVivetech::get_orders(@current_user['token'])
    @orders = response['data']
  end
    
  def show
    @title = t('orders.show')
    response = ApiVivetech::get_order({id: params[:id], token: @current_user['token']})
    if !response['status']
      flash[:alert] = t('orders.search')
      redirect_to controller: 'orders', action: "index"
    end
    @order = response['data']
  end
  
  def create
    response = ApiVivetech::create_order({data: params[:data], token: @current_user['token']})
    if response['status']
      flash[:alert] = t('orders.save.success')
      redirect_to controller: 'orders', action: "index"
    else
      flash[:warning] = t('orders.save.error')
      redirect_to controller: 'orders', action: "new"
    end
  end

end
