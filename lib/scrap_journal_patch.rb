# add a relation ship Journal +has_one+ Scrap
module ScrapJournalPatch

  def self.included(base) # :nodoc:
    Journal.extend(ClassMethods)
    Journal.send(:include, InstanceMethods)

    Journal.class_eval do
      unloadable
      has_one :scrap, :dependent => :destroy
      before_save :scrap_note
    end
  end

  module ClassMethods
  end

  module InstanceMethods
    def scrap_note
        quotes=""
        no_quote_body=""

        self.notes.each { |line|

          # could be a signature
          break if line == "--\n" or line == "--\r\n" or /^-- *\n/ =~ line

          l = line.sub(/^\t/,"")
          if l == "\n" or /^>/ =~ l
                quotes = quotes + line
          else
                no_quote_body = no_quote_body + quotes + line
                quotes=""
          end
        } unless self.notes.nil? or self.notes.blank?

        s = self.scrap.nil? ? Scrap.new : self.scrap
        s.note = no_quote_body == self.notes ? "" : no_quote_body
        self.scrap = s
	s.save
    end
  end
end
