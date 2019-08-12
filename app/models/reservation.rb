# == Schema Information
#
# Table name: reservations
#
#  id         :bigint           not null, primary key
#  end_at     :datetime         not null
#  num_guests :integer          default(1)
#  start_at   :datetime         not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  guest_id   :bigint
#  shift_id   :bigint
#  table_id   :bigint
#
# Indexes
#
#  index_reservations_on_guest_id  (guest_id)
#  index_reservations_on_shift_id  (shift_id)
#  index_reservations_on_table_id  (table_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_id => guests.id)
#  fk_rails_...  (shift_id => shifts.id)
#  fk_rails_...  (table_id => tables.id)
#

class Reservation < ApplicationRecord
  belongs_to :table
  belongs_to :guest
  belongs_to :shift
  
  validates :end_at, presence: true
  validates :num_guests, presence: true
  validates :start_at, presence: true
  validates :guest_id, presence: true
  validates :table_id, presence: true
  validates :shift_id, presence: true
  
  before_save :check_num_guests
  before_save :validate_start_and_end_at
  before_save :validate_shift_range
  before_save :check_table_reservation
  
  scope :for_range, lambda { |start_at, end_at|
    where(
      '("reservations"."end_at" >= :date_start AND "reservations"."start_at" <= :date_end)',
      date_start: start_at.to_datetime, date_end: end_at.to_datetime
    )
  }
  
  scope :for_restaurant, lambda { |restaurant|
    joins(:table)
      .where(tables: { restaurant_id: restaurant.id })
  }
  
  def check_num_guests
    return if (table.minimun_guest..table.maximun_guest).include? num_guests
    errors.add :num_guest, 'num guests is invalid'
  end
  
  def validate_start_and_end_at
    return if start_at < end_at
    errors.add(:end_at, 'can not be in the past')
  end
  
  def validate_shift_range
    shift_start_at = start_at.to_date + shift.start_at.hour.hours + shift.start_at.min.minutes
    shift_end_at = start_at.to_date + shift.end_at.hour.hours + shift.end_at.min.minutes
    errors.add(:start_at, 'can not be before than shift start') if shift_start_at > start_at
    errors.add(:end_at, 'can not be after than shift end') if end_at > shift_end_at
  end
  
  def check_table_reservation
    return if table.reservations.for_range(start_at, end_at).count.zero?
    errors.add :table_id, 'there is a reservation for this period'
  end
end
