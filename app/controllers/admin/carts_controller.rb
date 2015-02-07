class Admin::CartsController < AdminController
  before_action :set_admin_cart, only: [:show, :edit, :update, :destroy]

  # GET /admin/carts
  # GET /admin/carts.json
  def index
    @admin_carts = Admin::Cart.all
  end

  # GET /admin/carts/1
  # GET /admin/carts/1.json
  def show
  end

  # GET /admin/carts/new
  def new
    @admin_cart = Admin::Cart.new
  end

  # GET /admin/carts/1/edit
  def edit
  end

  # POST /admin/carts
  # POST /admin/carts.json
  def create
    @admin_cart = Admin::Cart.new(admin_cart_params)

    respond_to do |format|
      if @admin_cart.save
        format.html { redirect_to @admin_cart, notice: 'Cart was successfully created.' }
        format.json { render :show, status: :created, location: @admin_cart }
      else
        format.html { render :new }
        format.json { render json: @admin_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/carts/1
  # PATCH/PUT /admin/carts/1.json
  def update
    respond_to do |format|
      if @admin_cart.update(admin_cart_params)
        format.html { redirect_to @admin_cart, notice: 'Cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_cart }
      else
        format.html { render :edit }
        format.json { render json: @admin_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/carts/1
  # DELETE /admin/carts/1.json
  def destroy
    @admin_cart.destroy
    respond_to do |format|
      format.html { redirect_to admin_carts_url, notice: 'Cart was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_cart
      @admin_cart = Admin::Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_cart_params
      params[:admin_cart]
    end
end
