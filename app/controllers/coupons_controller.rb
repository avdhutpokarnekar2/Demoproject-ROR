class CouponsController < ApplicationController
    
  def create
    entered_code = params[:code] if params[:code].present?
    coupon = Coupon.find_by(code: entered_code)
    coupons = Coupon.all
    coupons.each do |c|
      if current_user.coupons.include?(coupon)
        flash[:alert] = "Coupon already applied."
      elsif entered_code == c.code 
        coupon.no_of_uses += 1  
        current_user.coupons << coupon
        total_off = (coupon.percent_off)
        redirect_to carts_path(coupon_off: total_off), notice: 'Coupon applied successfully.'
      else
        flash[:alert] = "Please enter a valid coupon code."
      end
    end
    redirect_to carts_path, alert: "Invalid Coupon."
  end

end


