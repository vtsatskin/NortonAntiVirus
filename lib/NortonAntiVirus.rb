require "NortonAntiVirus/version"
require 'json'

# Set these constants in your parent class
# PUBLIC_CREATEABLE_KEYS = []
# PUBLIC_UPDATABLE_KEYS = []
# PUBLIC_KEYS = []

module NortonAntiVirus

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # Creates an object from properties whitelisted in PUBLIC_CREATEABLE_KEYS from a given JSON string
    def create_from_public_json virus = String.new
      create_from_public_hash(JSON.parse(virus))
    end

    # Creates object from properties whitelisted in PUBLIC_CREATEABLE_KEYS
    def create_from_public_hash virus = {}
      filtered_params = {}
      self::PUBLIC_CREATEABLE_KEYS.each do |good_key|
        filtered_params[good_key] = virus[good_key]
      end

      # This method must be present in the parent Class
      self.create(filtered_params)
    end
  end

  # Updates self w/ filtered properties whitelisted in PUBLIC_UPDATABLE_KEYS from a given JSON string
  def update_properties_from_public_json virus = String.new
    update_properties_from_public_hash(JSON.parse(virus))
  end

  # Updates self w/ filtered properties whitelisted in PUBLIC_UPDATABLE_KEYS
  def update_properties_from_public_hash virus = {}
    filtered_params = {}
    self.class::PUBLIC_UPDATABLE_KEYS.each do |good_key|
      filtered_params[good_key] = virus[good_key]
    end

    unless filtered_params.empty?
      self.update filtered_params
      self.save
    end

    self
  end

  # Returns self w/ filtered properties whitelisted in PUBLIC_KEYS
  # formatted as JSON string
  def to_public_json
    self.to_public_hash.to_json
  end

  # Returns self w/ filtered properties whitelisted in PUBLIC_KEYS
  def to_public_hash
    hash = {}
    self.class::PUBLIC_KEYS.each { |key| hash[key] = self.send(key) }
    hash
  end
end