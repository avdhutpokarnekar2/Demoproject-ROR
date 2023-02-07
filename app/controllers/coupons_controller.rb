class CouponsController < ApplicationController
    
    def index
        @@user = current_user
        entered_code = params[:code]
        coopan = Coupon.find_by(code: entered_code)
        coupons = Coupon.all
        coupons.each do |c|
            if @user.coupons.include?(coopan)
                flash.now[:notice] = "Coupon already applied !"
            elsif entered_code == c.code 
                coopan.no_of_uses += 1  
                @user.coupons << coopan
                @total_off = @final_value*(coopan.percent_off)/100
                @order_total = @order_total - @total_off
                flash.now[:notice] = 'Coupon applied successfully'
            else
                @order_total
            end
        end
    end
end
