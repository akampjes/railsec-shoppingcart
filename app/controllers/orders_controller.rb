class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @orders = Order.where(user_id: current_user.id)
    respond_with(@orders)
  end

  def show
    #respond_with(@order)
    edit
  end

  def new
    create
  end

  def edit
    if @order.status == 'address'
      render 'orders/checkout/address'
    elsif @order.status == 'payment'
      render 'orders/checkout/payment'
    elsif @order.status == 'paid'
      render 'orders/checkout/paid'
    else
      flash[:error] = 'unrecognised status'
    end
  end

  def create
    @order = Order.new
    @order.status = 'address'
    @order.total = SecureRandom.random_number(1000) + SecureRandom.random_number.round(2)
    @order.user_id = current_user.id
    @order.save

    redirect_to orders_path
  end

  def update
    @order.update(order_params)
    if @order.status == 'address'
      @order.status = 'payment'
    elsif @order.status == 'payment'
      if params[:order][:fakecard] == '4111111111111111'
        @order.status = 'paid'
      else
        flash[:error] = 'Invalid card number'
      end
    elsif @order.status == 'paid'
    else
    end
    @order.save

    edit
  end

  def destroy
    @order.destroy
    respond_with(@order)
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(:address, :status, :fakecard)
    end
end
