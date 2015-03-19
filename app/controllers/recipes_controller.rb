class RecipesController < ApplicationController

  before_filter :recipe, only: [:destroy, :show, :update]
  skip_before_filter :verify_authenticity_token

  def index
    @recipes = if params[:keywords]
                 Recipe.where('name ilike ?', "%#{params[:keywords]}%")
               else
                 Recipe.all
               end
  end

  def show
  end


  def update
    @recipe.update_attributes params.require(:recipe).permit(:name, :instructions)
    head :no_content
  end

  def create
    @recipe = Recipe.new params.require(:recipe).permit(:name, :instructions)
    @recipe.save
    render 'show', status: 201
  end

  def destroy
    @recipe.destroy
    head :no_content
  end

  private
  def recipe
    @recipe = Recipe.find(params[:id])
  end
end
