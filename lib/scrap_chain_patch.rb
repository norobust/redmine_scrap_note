module ScrapChainPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)
    base.class_eval do
      alias_method_chain :render_notes, :scrap
    end
  end

  module InstanceMethods
    def render_notes_with_scrap(issue, journal, options={})
      unless journal.scrap.nil? 
        journal.notes = journal.scrap.note unless journal.scrap.note.blank?
      end

      render_notes_without_scrap(issue, journal, options = {})
    end
  end
end
