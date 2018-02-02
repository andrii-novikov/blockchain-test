class Node < ApplicationRecord
  SYNC_PATH = '/blockchain/get_blocks/10000'.freeze
  UPDATE_PATH = 'blockchain/receive_update'.freeze

  validates :node_id, :url, presence: true
  validates :node_id, uniqueness: true

  before_create :format_url

  def uri
    URI.parse "http://#{url}"
  end

  def sync_uri
    uri + SYNC_PATH
  end

  def update_uri
    uri + UPDATE_PATH
  end

  private

  def format_url
    return if url.blank?
    url.gsub!('http:','').gsub!('/','')
  end
end
