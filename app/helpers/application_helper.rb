module ApplicationHelper
  def assumptions_helper
    {
      "What additional attributes should be on a Project?" => "Just a name, description & status for now.",
      "What validations are needed for a Project?" => "Name is required.",
      "Does a project status need to be dynamic?" => "Not initially, but it could be useful in the future. Initially, we can just use Pending, In Progress, Blocked, and Completed.",
      "Should comments support rich media?" => "No, just text is fine for now.",
      "Should comments be threaded?" => "No, just a flat list is fine for now.",
      "Should comments be editable or deletable?" => "No, just creatable for now.",
      "What other things might we want to show in the feed?" => "Potentially any other attribute changes on a project",
      "What order should the feed be in?" => "Most recent at the bottom",
      "What meta information should be shown in the feed?" => "The time the comment was posted, along with the users avatar",
      "Are there any requirements around moderation or admin functions?" => "No, just a flat list is fine for now."
    }
  end
end
