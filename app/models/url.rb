class Url < ActiveRecord::Base
  before_save :generate_short_url

  def generate_short_url
    self.short_url = rand(20**15).to_s(36)
  end
end
