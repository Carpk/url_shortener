class Url < ActiveRecord::Base
  before_save :generate_short_url
  validate :must_be_valid_url

  def generate_short_url
    self.short_url = rand(20**15).to_s(36)
  end

  def clicked
    self.click_count += 1
    self.save
  end

  def must_be_valid_url
    unless self.long_url =~ /(https*:\/\/w*.)[a-zA-Z]+(.com).*/
      errors.add(:long_url, "must be a valid url")
    end
  end
end
