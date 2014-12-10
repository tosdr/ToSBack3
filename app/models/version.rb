# == Schema Information
#
# Table name: versions
#
#  id         :integer          not null, primary key
#  policy_id  :integer
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  full_page  :text
#  xpath      :string(255)
#

class Version < ActiveRecord::Base
  belongs_to :policy, inverse_of: :versions
  
  default_scope order("created_at DESC")  
  
  attr_accessible :text, :full_page
  
  validates :policy, :text, presence: true
  
  # Make sure this always stays *really* html_safe!
  #def changes_from_previous
    #current = display_policy
    #if prev = previous_version
      #Diffy::Diff.new(prev.previous_policy, current).to_s(:html).html_safe

      ## Differ.diff_by_line(current, prev.previous_policy).format_as(:html).html_safe
    #else
      #current.html_safe
      
      ## current.html_safe
    #end
  #end
  
  #def changes_with_current
    #if current_version?
      #display_policy.html_safe
      ## Differ.diff_by_line(current, prev.previous_policy).format_as(:html).html_safe
    #else
      #Diffy::Diff.new(previous_policy, policy.detail).to_s(:html).html_safe
      
      ## current.html_safe
    #end
  #end
  
  # TODO write test for this:
  #def display_policy
    #current_version? ? policy.detail : previous_policy
  #end
  
  protected
  
  def previous_version
    policy.versions.where("created_at < ?", created_at).first #returns nil when no previous versions
  end
  
  def current_version?
    self == policy.versions.first
  end
  
end
