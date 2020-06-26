module DeviseHelper
  def bootstrap_alert(key)
    case key
    when "success"
      "success"
    when "alert"
      "warning"
    when "notice"
      "success"
    when "error"
      "danger"
    end
  end
end
