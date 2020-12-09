class EmoneyController < ApplicationController
  # 電子マネー追加・編集・削除に管理ユーザーログインを要する場合はコメントアウト
  # before_action :check_admin_user, only: [:new, :edit, :create, :destroy]

  def index
  end

  def show
  end

  def new
    @emoney = Emoney.new
  end

  def edit
  end

  def create
    @emoney.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Emoney.find(params[:id]).destroy
    flash[:success] = '電子マネーを削除しました'
    redirect_back(fallback_location: emoney_index_path)
  end

  private

  def emoney_params
    params.require(:emoney).permit(:name, :category, :image, :link, :description)
  end

  # 電子マネー追加・編集・削除に管理ユーザーログインを要する場合はコメントアウト
  # def check_admin_user
  #   redirect_to(root_path) unless user_signed_in? && current_user.admin?
  # end
end
