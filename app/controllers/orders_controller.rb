class OrdersController < ApplicationController
skip_before_filter :authorize, :only => [:new, :create]

def index

@orders=Order.paginate :page=>params[:page], :order=>'created_at desc' , :per_page => 10
respond_to do |format|
format.html # index.html.erb
format.xml { render :xml => @orders }
end
end

def show
@order = Order.find(params[:id])
respond_to do |format|
format.html # show.html.erb
format.json { render :json => @order }
end
end

def new
if current_cart.line_items.empty?
redirect_to store_url, :notice => "Your cart is empty"
return
end
@order = Order.new
respond_to do |format|
format.html # new.html.erb
format.xml { render :xml => @order }
end
end

def edit
@order = Order.find(params[:id])
end

def create
@order = Order.new(params[:order])
@order.add_line_items_from_cart(current_cart)
@order.user_id=session[:user_id]
respond_to do |format|
if @order.save
Cart.destroy(session[:cart_id])
session[:cart_id] = nil
Notifier.order_received(@order).deliver
format.html { redirect_to(new_payment_path, :notice => 'Thank You for your order.') }
format.xml { render :xml => @order, :status => :created, :location => @order }
else
format.html { render :action => "new" }
format.xml { render :xml => @order.errors, :status => :unprocessable_entity }
end
end
end

def update
@order = Order.find(params[:id])
respond_to do |format|
if @order.update_attributes(params[:order])
format.html { redirect_to @order, :notice => 'Order was successfully updated.' }
format.json { head :ok }
else
format.html { render :action => "edit" }
format.json { render :json => @order.errors, :status => :unprocessable_entity }
end
end
end

def destroy
@order = Order.find(params[:id])
@order.destroy
respond_to do |format|
format.html { redirect_to orders_url }
format.json { head :ok }
end
end
end
