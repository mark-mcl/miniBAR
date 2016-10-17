class Bar < ActiveRecord::Base
  has_many :tabs
  has_many :patrons, through: :tabs

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :address, :city, presence: true
  validates :zipcode, presence: true, length: { is: 5 }
  validates :state, presence: true, length: { is: 2 }

  def self.bar_search(criteria)
    close_bars = self.where("zipcode = ?", criteria)
    puts "close_bars"
    p close_bars
    close_active_bars = close_bars.active_bars
    puts "close_active_bars"
    p close_active_bars
  end

  def self.active_bars
    active_bars = self.where("discoverable = ?", true)
    active_bars
  end

  def close_all_tabs
    open_tabs = tabs.where(closed: false)
    open_tabs.each do |tab|
      tab.closed = true
      tab.save
    end
  end

end
