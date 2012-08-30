require 'redmine'

require 'dispatcher'

Dispatcher.to_prepare do
  require_dependency 'journal'
  require_dependency 'journals_helper'

  #application.rb changed names between rails verisons - hack for backwards compatibility
  begin
    require_dependency 'application_controller'
  rescue MissingSourceFile
    require_dependency 'application'
  end

  #This file loads some associations into the core redmine classes, like associations to todos.
  require 'scrap_journal_patch'
  require 'scrap_chain_patch'
  require 'issue_history_hook'

  # Add module to Project.
  Journal.send(:include, ScrapJournalPatch)

  # Add module to JournalsHelper
  JournalsHelper.send(:include, ScrapChainPatch)

end

Redmine::Plugin.register :redmine_scrap_note do
  name 'Redmine Scrap Note plugin'
  author "Nakai To'oru"
  description 'Manage journal scrap note to remove email reply'
  version '0.0.1'
  url 'https://github.com/norobust/redmine_scrap_note'
  author_url 'https://github.com/norobust'
end
