class PaymentController < ApplicationController 

def new
@pay=Payment.new
end


def create
@pay=Payment.new(params[:payment])

gateway = ActiveMerchant::Billing::PaypalGateway.new(
        :login => "ambrut_1328351308_biz_api1.railsfactory.org",
        :password => "1328351347",
        :signature => "AFcWxV21C7fd0v3bYYYRCpSSRl31AbPkUhbEO8XCnzgjTa.g9c2vTdBx",
        :test => true
)
credit_card = ActiveMerchant::Billing::CreditCard.new(
    :type                   => "#{params[:payment][:card_type]}",
    :number                 => "#{params[:payment][:card_no]}",
    :verification_value     => "#{params[:payment][:card_verification]}",
    :month                  => "#{params[:payment][:expiry_date_month]}",
    :year                   => "#{params[:payment][:expiry_date_year]}",
    :first_name             => "#{params[:payment][:first_name]}",
    :last_name              => "#{params[:payment][:last_name]}"
  
)
p credit_card

@amount="#{params[:payment][:amount]}"
p "$$$$$$$5546758568$"
p @amount
p "$$$$$8t67567$$$"

if credit_card.valid?
response = gateway.purchase(@amount.to_i,credit_card,:ip => "127.0.0.1", :billing_address => { 
    :name     => "ambrutha",
    :address1 => "7,jadamuni koil st",
    :city     => "madurai",
    :state    => "Tamilnadu",
    :country  => "India",
    :zip      => "625020"

} )    

    if response.success?
@pay.save
       puts "Purchase complete!"
       redirect_to "/store/index"
    else
       puts "Error: #{response.message}"
       redirect_to  "/payment/error"
    end
   
else
  puts "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}"
  #flash[:failure] = "Sorry Input Invalid"
  redirect_to  "/payment/new"
end
end

def error
end


end

