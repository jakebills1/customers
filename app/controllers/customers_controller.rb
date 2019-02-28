class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    # Active record
    # @customer = Customer.all

    # find_by_sql - SELECT all records
    @customers = Customer.all_customers(current_user.id)
  end

  def show
  end

  def new
    @customer = current_user.customers.new
  end

  def create
    # Active record
    # @customer = current_user.customers.new(customer_params)
    Customer.create_customer(customer_params, current_user.id)
    redirect_to customers_path
  end

  def edit
  end

  def update
    Customer.update_customer(customer_params, @customer.id)
    redirect_to customers_path
  end

  def destroy
    Customer.delete_customer(@customer.id)
    redirect_to customers_path
  end

  private
    def set_customer
      # active record
      # @customer = Customer.find(params[:id])

      # find_by_sql - SELECT single record
      @customer = Customer.single_customer(current_user.id, params[:id])
    end

    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :email, :phone)
    end
end
