require 'csv'
class Admin::ProductsController < ApplicationController

  def index
    respond_to do |format|
      format.html
      format.csv {

        sleep(10)
        csv_string = CSV.generate do |csv|
          csv << ["id", "name", "qty", "price"]

          Product.find_each do |p|
            csv << [p.id, p.name, p.qty, p.price]
          end

        end

        render :text => csv_string
      }
    end
  end

  def export
    ProductExportWorker.perform_async
    flash[:alert] = "資料匯出中, 請稍候!!"

    redirect_to :back
  end

end
