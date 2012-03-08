class CartsController < ApplicationController

def index
@carts = Cart.all
respond_to do |format|
format.html # index.html.erb
format.json { render :json => @carts }
end
end

def show
begin
@cart = Cart.find(params[:id])
rescue ActiveRecord::RecordNotFound
logger.error "Attempt to access invalid cart #{params[:id]}"
redirect_to store_url, :notice => 'Invalid cart'	
else
respond_to do |format|
format.html # show.html.erb
format.xml { render :xml => @cart }
end
end
end

def new
@cart = Cart.new
respond_to do |format|
format.html # new.html.erb
format.json { render :json => @cart }
end
end

def edit
@cart = Cart.find(params[:id])
end

def create
@cart = Cart.new(params[:cart])
respond_to do |format|
if @cart.save
format.html { redirect_to @cart, :notice => 'Cart was successfully created.' }
format.json { render :json => @cart, :status => :created, :location => @cart }
else
format.html { render :action => "new" }
format.json { render :json => @cart.errors, :status => :unprocessable_entity }
end
end
end

def update
@cart = Cart.find(params[:id])
respond_to do |format|
if @cart.update_attributes(params[:cart])
format.html { redirect_to @cart, :notice => 'Cart was successfully updated.' }
format.json { head :ok }
else
format.html { render :action => "edit" }
format.json { render :json => @cart.errors, :status => :unprocessable_entity }
end
end
end

def destroy
@cart = Cart.find(params[:id])
@cart.destroy
session[:cart_id] = nil
respond_to do |format|
format.html { redirect_to(store_url) }
format.xml { head :ok }
end
end
end






