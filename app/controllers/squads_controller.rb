module SquadsController
  def create_squad!(*args)
    interactor = CreateSquad.call(user: current_user, squad_attributes: args)
    if interactor.success?
      respond_with :message, text: t('.success', username: '@'+ current_user.username)
    else
      interactor.errors.full_messages.each { |m| respond_with :message, text: "#{m}" }
    end
  end

  def join_squad!(*args)
    interactor = Squad::AddUser.call(user: current_user, squad_name: args.first)
    if interactor.success?
      respond_with :message, text: t('.success', squad_name: interactor.squad.name)
    else
      interactor.errors.full_messages.each { |m| respond_with :message, text: "#{m}" }
    end
  end

  def leave_squad!(*args)
    interactor = Squad::DeleteUser.call(user: current_user, squad_name: args.first)
    if interactor.success?
      respond_with :message, text: t('.success')
    else
      respond_with :message, text: t('.failure')
    end
  end

  def squad_boys!(*args)
    squad = Squad.find_by_name(args.first)
    if squad
      users = squad.users.map(&:usertag).join(' ')
      respond_with :message, text: t('.squad', squad_name: squad.name)
      respond_with :message, text: t('.users', users: users)
    else
      respond_with :message, text: t('.no_squad')
    end
  end

  def my_squads!(*)
    squads = current_user.squads.map(&:name).join(' ')

    if squads.present?
      reply_with :message, text: t('.success', username: '@'+ current_user.username, squads: squads)
    else
      reply_with :message, text: t('.failure')
    end
  end
end