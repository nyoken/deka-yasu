# frozen_string_literal: true

class EmoneyController < ApplicationController
  # 電子マネー追加・編集・削除に管理ユーザーログインを要する場合はコメントアウト
  # before_action :check_admin_user, only: [:new, :edit, :create, :destroy]
  before_action :set_categories, only: [:index, :new, :create]

  def index
  end

  def show
    @emoney = Emoney.find(params[:id])
  end

  def new
    @emoney = Emoney.new
  end

  def edit
    @emoney = Emoney.find(params[:id])
  end

  def create
    @emoney = Emoney.new(emoney_params)
    if @emoney.save
      flash[:success] = '電子マネーを追加しました'
      redirect_to emoney_index_path
    else
      flash[:error] = '電子マネーの登録に失敗しました'
      render 'new'
    end
  end

  def update
    @emoney = Emoney.find(params[:id])
    if @emoney.update_attributes(emoney_params)
      flash[:success] = '電子マネー情報を更新しました'
      redirect_to @emoney
    else
      flash[:error] = '電子マネーの更新に失敗しました'
      render 'edit'
    end
  end

  def destroy
    Emoney.find(params[:id]).destroy
    flash[:success] = '電子マネーを削除しました'
    redirect_to emoney_index_url
  end

  private

  def emoney_params
    params.require(:emoney).permit(:name, :category_id, :image, :link, :description)
  end

  def set_categories
    @categories = Category.all
  end

  # 電子マネー追加・編集・削除に管理ユーザーログインを要する場合はコメントアウト
  # def check_admin_user
  #   redirect_to(root_path) unless user_signed_in? && current_user.admin?
  # end
end
