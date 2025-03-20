class DecisionsController < ApplicationController
  def new
    @decision = Decision.new
  end

  def create
    @decision = Decision.new(decision_params)
    if @decision.save
      redirect_to decisions_path(@decision), notice: "Décision crée et ajoutée à la liste"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @decision = Decision.find(params[:id])
  end

  private
    def decision_params
      params.expect(decision: [ :chapter, :name, :date, :summary ])
    end
end
