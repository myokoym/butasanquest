class EventPage
  attr_reader :character, :comments
  
  def initialize(character, comments)
    @character = character
    @comments = comments
  end
end
