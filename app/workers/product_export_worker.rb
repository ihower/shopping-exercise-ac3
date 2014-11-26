class ProductExportWorker
  include Sidekiq::Worker

  def perform
        csv_string = CSV.generate do |csv|
          csv << ["id", "name", "qty", "price"]
          Product.find_each do |p|
            csv << [p.id, p.name, p.qty, p.price]
          end

        end

        s = StringIO.new(csv_string)
        def s.original_file
          "products.csv"
        end

        e = Export.new( :export => s )
        e.save!

        # Sending email
  end

end