class ApplicationController < ActionController::API
  def respond_with(resource_or_collection)
    valid?(resource_or_collection) ? success(resource_or_collection) : failure(resource_or_collection)
  end

  def success(resource_or_message, status: :ok)
    json = { success: true, status: status, message: message_from_resource(resource_or_message) }
    render json: json, location: false, status: status
  end

  def failure(resource_or_message, status: :unprocessable_entity)
    json = { success: false, status: status, message: display_errors(resource_or_message) }
    render json: json, location: false, status: status
  end

  def message_from_resource(resource, **options)
    ActiveModelSerializers::SerializableResource.new(resource, options).as_json
  end

  def valid?(resource_or_collection)
    collection?(resource_or_collection) ? resource_or_collection.all?(&:valid?) : resource_or_collection.valid?
  end

  def display_errors(resource_or_collection)
    block = ->(r) { r.errors.full_messages.first }
    collection?(resource_or_collection) ? resource_or_collection.map(&block) : block.call(resource_or_collection)
  end

  def collection?(resource_or_collection)
    resource_or_collection.kind_of?(Enumerable)
  end
end
