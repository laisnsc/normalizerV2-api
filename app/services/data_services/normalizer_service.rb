module DataServices
  class NormalizerService
    class << self
      def process_data(data)
        normalized_data = normalize_data(data)
        persist_data(normalized_data)
      end

      private

      def normalize_data(data)
        user_data = {}
        user_orders_data = []
        data.each do |row|
          user_id = row[0...10].to_i
          name = row[10...55].strip
          order_id = row[55...65].to_i
          product_id = row[65...75].to_i
          product_name = "prod_#{product_id}"
          value = row[75...87].to_f
          date = DateTime.parse(row[87...95])
          user_data[user_id] = { user_id: user_id, name: name }
          user_orders_data << { user_id: user_id, order_id: order_id, date: date, product_id: product_id,
                                value: value, name: product_name }
        end

        file_order_values = user_orders_data.map { |uod| uod[:order_id] }.uniq.sort
        { "users" => user_data.values, "orders" => user_orders_data, "order_ids" => file_order_values }
      end

      def persist_data(data)
        ApplicationRecord.transaction do
          begin
            find_or_create_object(data["users"], "user", :name)
            find_or_create_object(data["orders"], "order", :user_id, :date)
            find_or_create_object(data["orders"], "product", :name)
            find_or_create_object(data["orders"], "order_product", :order_id, :product_id, :value)
            { success: true }
          rescue StandardError => e
            Rails.logger.error "Error processing data: #{e.message}"
            raise ActiveRecord::Rollback
          end
        end

        { success: false, error: "Unknown processing error" }
      rescue StandardError => e
        { success: false, error: e.message }
      end

      def find_or_create_object(objects, model, *params)
        model_class = Object.const_get("#{model.classify}")
        objects.each do |object|
          attributes = params.map { |param| [ param, object[param] ] }.to_h
          record = model_class.find_or_initialize_by(id: object["#{model}_id".to_sym])
          record.assign_attributes(attributes)
          record.save!
        end
      end
    end
  end
end
