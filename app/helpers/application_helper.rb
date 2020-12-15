# frozen_string_literal: true

module ApplicationHelper
  def button
    controller.action_name == "new" ? '追加' : '更新'
  end
end
