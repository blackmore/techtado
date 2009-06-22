class CustomersController < ApplicationController
  
  def index
    @customers = Customer.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
  end
end