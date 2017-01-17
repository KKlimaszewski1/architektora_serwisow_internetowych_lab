class RecipesController < ApplicationController
  before_action :find_user

  def index
    if params[:search].blank?
      @recipes = Recipe.all
    else
      @recipes = Recipe.search(params[:search])
    end
  end

  def search
    @recipes = Recipe.all
  end
 
  def show
    @recipe = Recipe.find(params[:id])
    @comments = Comment.where(recipe_id: @recipe).order("created_at DESC")
    @user = User.find(@recipe.user_id)
  end
 
  def new
    @recipe = Recipe.new
  end
 
  def edit
    @recipe = Recipe.find(params[:id])
  end
 
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
    @recipe.save

    if @recipe.save
        redirect_to @recipe
    else
        render 'new'
    end

  end
 
  def update
    @recipe = Recipe.find(params[:id])
 
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end
 
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
 
    redirect_to recipes_path
  end
 
  private

  def recipe_params
    params.require(:recipe).permit(:tytuł, :składniki, :opis)
  end

  def find_user
    @current_user = User.find_by(id: session[:user_id])
  end

end