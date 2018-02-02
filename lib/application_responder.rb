class ApplicationResponder < ActionController::Responder
  include Responders::HttpCacheResponder

  def display_errors
    controller.render format => resp(success: false, message: first_resource_error), status: :unprocessable_entity
  end

  def api_behavior
    raise MissingRenderer.new(format) unless has_renderer?

    if get?
      display resource
    elsif post?
      display resp(status: :created), status: :created, location: false
    else
      head :no_content
    end
  end

  private

  def api_location
    false
  end

  def first_resource_error
    resource.errors.full_messages.first
  end

  def resp(success: true, status: '', message: '')
    { success: success, status: status, message: message }
  end
end
