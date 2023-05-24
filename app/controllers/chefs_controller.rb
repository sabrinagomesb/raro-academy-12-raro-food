# frozen_string_literal: true

class ChefsController < ApplicationController
  include ControllersHelper
  before_action :set_chef, only: %i[show edit update destroy]
  before_action :set_approver, only: %i[new create edit update]

  # GET /chefs or /chefs.json
  def index
    @chefs = Chef.all
  end

  # GET /chefs/1 or /chefs/1.json
  def show; end

  # GET /chefs/new
  def new
    @chef = Chef.new
    @chef.build_address
    @chef.build_user
  end

  # GET /chefs/1/edit
  def edit; end

  # POST /chefs or /chefs.json
  def create
    @chef = Chef.new(chef_params)

    respond_to do |format|
      if @chef.save
        format.html { redirect_to chef_url(@chef), notice: "Chef was successfully created." }
        format.json { render :show, status: :created, location: @chef }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @chef.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chefs/1 or /chefs/1.json
  def update
    respond_to do |format|
      if @chef.update(chef_params)
        format.html { redirect_to chef_url(@chef), notice: "Chef was successfully updated." }
        format.json { render :show, status: :ok, location: @chef }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chef.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chefs/1 or /chefs/1.json
  def destroy
    @chef.destroy

    respond_to do |format|
      format.html { redirect_to chefs_url, notice: "Chef was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_chef
    @chef = Chef.find(params[:id])
  end

  def set_approver
    @approver = Administrator.first
  end

  # Only allow a list of trusted parameters through.
  def chef_params
    params.require(:chef).permit(
      :user_id,
      :approver_id,
      user_attributes: %i[id name cpf email password],
      address_attributes: %i[name public_place zip_code reference complement number neighborhood city_id],
    )
  end
end
