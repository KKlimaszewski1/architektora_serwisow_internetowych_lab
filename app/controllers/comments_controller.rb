class CommentsController < ApplicationController
    before_action :find_recipe, :find_user
    before_action :find_comment, only: [:destroy, :edit, :update, :comment_owner]
    before_action :comment_owner, only: [:destroy, :edit, :update]
    def new

    end

    def update
        if @comment.update(params[:comment].permit(:content))
            redirect_to recipe_path(@recipe)
        else
            render 'edit'
        end
    end
    
    def destroy
        @comment.destroy
        redirect_to recipe_path(@recipe)
    end

    def create
        @comment = @recipe.comments.create(params[:comment].permit(:content))
        @comment.user_id = current_user.id
        @comment.save

        if @comment.save
            redirect_to recipe_path(@recipe)
        else
            render 'new'
        end
    end

    private

    def find_recipe
        @recipe = Recipe.find(params[:recipe_id])
    end

    def find_user
        @current_user = User.find_by(id: session[:user_id])
    end

    def find_comment
        @comment = @recipe.comments.find(params[:id])
    end

    def comment_owner
        if current_user.nil? || current_user.id != @comment.user_id
            flash[:warning] = "Komentarz napisany jest przez innego użytkownika. Nie mozesz go edytować ani usunąć."
            redirect_to @recipe 
        end
    end
end
