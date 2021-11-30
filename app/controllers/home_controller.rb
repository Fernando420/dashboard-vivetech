class HomeController < ApplicationController

  def index
    @title = t('common_texts.home')
  end

end
