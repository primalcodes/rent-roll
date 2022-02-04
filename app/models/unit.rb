# frozen_string_literal: true

# Unit
class Unit < ApplicationRecord
  enum floor_plan: { Studio: 0, Suite: 1 }

  #----------------------------------------------------------------------------
  # Scopes
  #----------------------------------------------------------------------------
  default_scope { order(:unit_number) }
  scope :vacant, ->(date) { where('move_in IS NULL OR move_out < ?', date) }
  scope :current, ->(date) { where('move_in <= ? AND (move_out IS NULL OR move_out >= ?)', date, date) }
  scope :future, ->(date) { where('move_in > ?', date) }

  #----------------------------------------------------------------------------
  # Validations
  #----------------------------------------------------------------------------
  validates :unit_number, presence: true
  validates :floor_plan, presence: true
  validates :floor_plan, inclusion: { in: floor_plans.keys,
                                      message: "floor_plan must be one of #{floor_plans.keys}" }

  #----------------------------------------------------------------------------
  # Instance Methods
  #----------------------------------------------------------------------------
  def resident_status_for_date(date: Date.today)
    return :vacant if move_in.nil? && move_out.nil?

    return :vacant if move_out.present? && move_out < date

    return :future if move_in > date && move_out.nil?

    :current
  end

  #----------------------------------------------------------------------------
  # Class Methods
  #----------------------------------------------------------------------------
  def self.leased(date)
    (current(date) + future(date)).uniq
  end
end
