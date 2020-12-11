# frozen_string_literal: true

module EmoneyHelper
  def desplay_image(emoney)
    emoney.image? ? image_tag(emoney.image_url(:thumb)) : image_tag('noimage.gif')
  end
end
