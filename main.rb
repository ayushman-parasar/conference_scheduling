require_relative "sessions"
class Conference < Sessions
  attr_reader :session

  def initialize(session)
    @session = session
  end

  def start_session
    session.adding_programs
  end
end
sessions = Sessions.new
conference = Conference.new(sessions).start_session