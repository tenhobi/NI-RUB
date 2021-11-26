module PeopleHelper
  def schools_for_select
    School.all.map { |school| [school.name, school.id] }
  end
end
