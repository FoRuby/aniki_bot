module NotesController
  def feedback!(*args)
    interactor = CreateNote.call(user: current_user, note_attributes: args)
    if interactor.success?
      reply_with :message, text: t('.success')
    else
      render_errors(interactor.errors)
    end
  end
end