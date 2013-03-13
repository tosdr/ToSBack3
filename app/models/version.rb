# == Schema Information
#
# Table name: versions
#
#  id             :integer          not null, primary key
#  policy_id      :integer
#  previous_crawl :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Version < ActiveRecord::Base
  belongs_to :policy
  
  default_scope order("created_at DESC")  
  
  attr_accessible :previous_crawl
  
  validates :policy_id, :previous_crawl, presence: true
  
  # Make sure this always stays *really* html_safe!
  def changes_from_previous
    current = current_version? ? policy.detail : previous_crawl
    if prev = previous_version
      Differ.diff_by_word(current, prev.previous_crawl).format_as(:html).html_safe
    else
      current.html_safe
    end
  end
  
  protected
  
  def previous_version
    policy.versions.where("created_at < ?", created_at).first #returns nil when no previous versions
  end
  
  def current_version?
    previous_crawl == "Current Version"
  end
  
end
