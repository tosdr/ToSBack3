class PolicyPresenter

  def initialize(policy)
    @policy = policy
    @versions_empty = @policy.versions.empty?
  end

  def name
    @policy.name
  end

  def versions
    @policy.versions.limit(10)
  end

  def default_version_text
    @versions_empty ? "Sorry, there are no versions of this policy stored yet!" : @policy.versions.first.text.html_safe
  end

  def default_date
    @versions_empty ? " " : "<h3>ToSBack stored this version on #{@policy.versions.first.created_at.to_date.strftime("%B %-d, %Y")}</h3>".html_safe
  end
end
