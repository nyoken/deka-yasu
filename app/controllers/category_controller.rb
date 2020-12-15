class CategoryController < ApplicationController
  # カテゴリーの作成は管理者ユーザーのみに許可
  before_action :check_admin_user, only: [:new, :edit, :create, :update, :destroy]
  before_action :set_categories, only: [:new, :edit]

  def show
    @category = Category.find(params[:id])
    @other_categories = Category.where.not(id: params[:id])
  end

  def new
    @category = Category.new
  end

  def edit
    @category = Category.find(params[:id])
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

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:success] = 'カテゴリー情報を更新しました'
      redirect_to root_path
    else
      flash[:error] = 'カテゴリーの更新に失敗しました'
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = 'カテゴリーを削除しました'
    redirect_to root_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
