module PublicationsHelper
  def authors_for_select
    Person.all.map { |person| [person.full_name, person.id] }
  end
end
