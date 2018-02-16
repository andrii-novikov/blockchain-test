class Node < ApplicationRecord
  SYNC_PATH = 'blockchain/get_blocks/10000'.freeze
  UPDATE_PATH = 'blockchain/receive_update'.freeze
  STATUS_PATH = 'management/status'.freeze

  validates :node_id, :url, presence: true
  validates :node_id, uniqueness: true

  before_create :format_url

  def uri
    cast_uri
  end

  def sync_uri
    cast_uri(SYNC_PATH)
  end

  def update_uri
    cast_uri(UPDATE_PATH)
  end

  def status_uri
    cast_uri(STATUS_PATH)
  end

  private

  def cast_uri(path = nil, schema = 'http://')
    URI.parse [schema + url, path].compact.join('/')
  end

  def format_url
    return if url.blank?
    url.gsub!(%r[https?://],'')
  end
end
