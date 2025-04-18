class DecisionsController < ApplicationController
  def new
    @decision = Decision.new
  end

  def create
    @decision = Decision.new(decision_params)
    if @decision.save
      redirect_to decision_path(@decision), notice: "Décision crée et ajoutée à la liste"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @decision = Decision.find(params[:id])
  end

  def edit
    @decision = Decision.find(params[:id])
  end

  def update
    @decision = Decision.find(params[:id])
    if @decision.update(decision_params)
      redirect_to decision_path(@decision), notice: "Décision modifiée"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def index
    # @decisions = Decision.all
    @decisions = Decision.order(created_at: :asc).page(params[:page]).per(7)
  end

  def destroy
    @decision = Decision.find(params[:id])
    @decision.destroy
    redirect_to decisions_path, alert: "Décision supprimée de la liste"
  end

  private
    def decision_params
      params.expect(decision: [ :chapter, :name, :date, :summary ])
    end
end
