module CurrentNumber
  extend ActiveSupport::Concern

private

  def current_number
    session[:current_number]||=[]
    if not session[:current_number].empty?
      @dial_number_array = session[:current_number]
    end
  end
end