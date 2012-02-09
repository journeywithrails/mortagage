class Common::TaxRateController < ApplicationController
  def get
    respond_to do |format|

      format.js do
        id_is_num = true if Float(params[:tax_filing_status_id]) rescue false
        income_is_num = true if Float(params[:household_financial_estimated_income]) rescue false

        max_income_cents = TaxRate.maximum('top_income_in_cents')
        estimated_income_cents = params[:household_financial_estimated_income].to_f * 100 if income_is_num

        estimated_income_cents = [max_income_cents, estimated_income_cents].min

        tax_rate = TaxRate.find(:first, :conditions => ["tax_filing_status_id = ? and top_income_in_cents >= ?", params[:tax_filing_status_id], estimated_income_cents], 
          :order => 'top_income_in_cents', 
          :limit => 1) if (id_is_num && income_is_num)

        render :update do |page|
          if tax_rate
            page.replace_html 'estimated_tax_rate', "#{tax_rate.tax_pct}%"
            page['household_financial_tax_rate_id'].value = tax_rate.id
          else
            page.replace_html 'estimated_tax_rate', "&nbsp"
            page['household_financial_tax_rate_id'].value = ''
          end
          page.visual_effect :highlight, 'estimated_tax_rate'
        end 

      end if request.xhr?

      format.html { redirect_to home_path }

    end
  end
end
