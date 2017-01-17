class Recipe < ApplicationRecord
    belongs_to :user
    has_many :comments


    def self.search(params)
        recipes = Recipe.where("tytuł LIKE ?", "%#{params[:search]}%") if params[:search].present?
    end
end
