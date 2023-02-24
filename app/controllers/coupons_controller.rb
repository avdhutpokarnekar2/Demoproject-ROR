class CouponsController < ApplicationController
    
  def create
    entered_code = params[:code] if params[:code].present?
    code_coupon = Coupon.find_by(code: entered_code)
    coupons = Coupon.all
    coupons.each do |c|
      if current_user.coupons.include?(code_coupon)
        render carts_path flash[:alert] = "Coupon already applied."
      elsif entered_code == c.code 
        code_coupon.no_of_uses += 1  
        current_user.coupons << code_coupon
        total_off = (code_coupon.percent_off)
        redirect_to carts_path(coupon_off: total_off), notice: 'Coupon applied successfully.'
      end
    end
  end

end


