class CouponsController < ApplicationController
    
  def create
    @user = current_user
    entered_code = params[:code]
    coopan = Coupon.find_by(code: entered_code)
    coupons = Coupon.all
    coupons.each do |c|
      if @user.coupons.include?(coopan)
      
      elsif entered_code == c.code 
        coopan.no_of_uses += 1  
        @user.coupons << coopan
        total_off = (coopan.percent_off)
        redirect_to carts_path(coupon_off: total_off), notice:  'Coupon applied successfully'
      else
      end
    end
    redirect_to carts_path,  alert: "Invalid Coupon"
  end
end


