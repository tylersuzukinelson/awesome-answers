class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  has_many :comments, through: :answers

  validates :title, presence: true, uniqueness: {scope: :body, case_sensitive: false}, format: /.+/
  validates :body, presence: {message: "must be provided!!"}
  validates :view_count, numericality: {greater_than_or_equal_to: 0}
  validate :stop_words

  #     SOME COMMON CALL BACKS:
  # after_initialize
  # before_validation
  # after_validation
  # before_save
  # after_save
  # before_commite
  after_initialize :set_defaults

  # Example of the short way to do a class method
  scope :recent, lambda { |num| order("updated_at DESC").limit(num) }
  # scope :last_x_days, lambda { |num| order("created_at < CURRENT_DATE - INTERVAL '#{num} days'")} # Similar to below, but this will use the database server's time instead of the Ruby server's time
  scope :last_x_days, lambda { |num| where(created_at: num.days.ago..Time.now) }
  # scope :last_x_days, lambda { |num| where("created_at > ?", num.days.ago)}

  # Example of the long way to do a class method
  def self.recent(num)
    order("updated_at DESC").limit(num)
  end

  private

  def stop_words
    if title.include? "monkey"
      errors.add(:title, "Please don't use 'monkey'!")
    end
  end

  def set_defaults
    self.view_count ||= 0
  end
end
