class CategoryController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @other_categories = Category.where.not(id: params[:id])
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'カテゴリーを追加しました'
      redirect_to root_path
    else
      flash[:error] = 'カテゴリーの登録に失敗しました'
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
