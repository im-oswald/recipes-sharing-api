# frozen_string_literal: true

class UnitConverter
  SUPPORTED_UNITS = I18n.t('units.defaults').with_indifferent_access.freeze

  UNIT_REMOVER_REGEX = r = /(\d+)([[:alpha:]]+)/x             

  attr_reader :value, :conversion_unit, :with_unit

  def self.call(value, conversion_unit, with_unit = false)
    new(value: value, conversion_unit: conversion_unit, with_unit: with_unit).call
  end

  def initialize(value:, conversion_unit:, with_unit:)
    @value = value
    @conversion_unit = conversion_unit.to_s
    @with_unit = with_unit
  end

  def call
    return unless value && conversion_unit

    convert
  rescue StandardError => e
    Exceptions.print_error e

    value.scan(UNIT_REMOVER_REGEX).flatten.first
  end

  private

  def convert
    response = sanitize_value.to_s(conversion_unit)

    with_unit ? response : response.split(' ').first
  end

  def sanitize_value
    number, unit = value.gsub(/ /, '').scan(UNIT_REMOVER_REGEX).flatten

    return prepare_unit(number, unit) if SUPPORTED_UNITS.keys.include?(unit)

    unit = SUPPORTED_UNITS.find{ |key, value| value.include?(unit) }&.first

    raise "Unsupported format for conversion" unless unit

    prepare_unit(number, unit)
  end

  def prepare_unit(number, unit)
    Unit.new("#{number}#{unit}")
  end
end