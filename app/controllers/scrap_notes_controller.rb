class ScrapNotesController < ApplicationController
  unloadable

  def show_scrapped_note
    @journal = Journal.find(params[:id])
    # show as prefix document
    @journal.notes = "<pre>\n#{@journal.notes}</pre>"
    render :partial => 'show_scrapped_note'
  end
end
