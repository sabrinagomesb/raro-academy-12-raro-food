# frozen_string_literal: true

class OrderItemsController < ApplicationController
  before_action :set_order, only: %i[index edit show new create update destroy]
  before_action :set_order_item, only: %i[show edit update destroy]

  def index
    @order_items = OrderItem.all
  end

  def show
    render json: @order_item
  end

  # GET /orders/new
  def new
    @order_item = OrderItem.new
    @default_order_id = @order.id
  end

  def edit; end

  def create
    @order_item = OrderItem.new(order_item_params)

    respond_to do |format|
      if @order_item.save
        format.html { redirect_to edit_order_url(@order), notice: "Order item was successfully created." }
        format.json { render json: { message: "Order item successfully created", order_item: @order_item }, status: :created, location: @order_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: "Error: order item not created", errors: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order_item.update(order_item_params)
        format.html { redirect_to edit_order_url(@order), notice: "Order item was successfully updated." }
        format.json { render json: { message: "Order item successfully updated", order_item: @order_item }, status: :ok, location: @order_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: "Error: order item not updated", errors: @order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order_item.destroy

    respond_to do |format|
      format.html { redirect_to edit_order_url(@order), notice: "Order item #{@order_item.dish.name} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_order
    return unless params[:order_id]

    @order = Order.find(params[:order_id])
  end

  def set_order_item
    @order_item = @order.items.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:dish_id, :order_id, :amount, :unit_price)
  end
end
