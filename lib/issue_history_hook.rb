class ShowScrappedNotesHook < Redmine::Hook::ViewListener

  render_on :view_issues_history_journal_bottom, :partial => "history_bottom_hook"

end
