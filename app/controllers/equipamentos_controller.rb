class EquipamentosController < ApplicationController
  before_action :set_equipamento, only: %i[ show edit update destroy ]

  # GET /equipamentos or /equipamentos.json
  def index
    @equipamentos = Equipamento.all
  end

  # GET /equipamentos/1 or /equipamentos/1.json
  def show
  end

  # GET /equipamentos/new
  def new
    @equipamento = Equipamento.new
  end

  # GET /equipamentos/1/edit
  def edit
  end

  # POST /equipamentos or /equipamentos.json
  def create
    @equipamento = Equipamento.new(equipamento_params)

    respond_to do |format|
      if @equipamento.save
        format.html { redirect_to equipamento_url(@equipamento), notice: "Equipamento was successfully created." }
        format.json { render :show, status: :created, location: @equipamento }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @equipamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipamentos/1 or /equipamentos/1.json
  def update
    respond_to do |format|
      if @equipamento.update(equipamento_params)
        format.html { redirect_to equipamento_url(@equipamento), notice: "Equipamento was successfully updated." }
        format.json { render :show, status: :ok, location: @equipamento }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @equipamento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipamentos/1 or /equipamentos/1.json
  def destroy
    @equipamento.destroy!

    respond_to do |format|
      format.html { redirect_to equipamentos_url, notice: "Equipamento was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipamento
      @equipamento = Equipamento.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def equipamento_params
      params.fetch(:equipamento, {})
    end
end
