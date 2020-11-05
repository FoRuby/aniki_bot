class Note::Create < BaseInteractor
  attr_reader :note_attributes, :note, :user

  before :assign_attributes

  def call
    create_note
    set_up_note
  end

  private

  def assign_attributes
    @note_attributes = {}
    @note_attributes[:body] = context.note_attributes.join(' ')
    @user = context.user
  end

  def create_note
    @note = user.notes.new(note_attributes)

    note.save ? set_up_note : fail_interactor!(note.errors)
  end

  def set_up_note
    context.note = note
  end
end