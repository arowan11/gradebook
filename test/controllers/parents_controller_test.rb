require 'test_helper'

class ParentsControllerTest < ActionDispatch::IntegrationTest
  test "teacher can create parents inside student" do
    kvothe = Student.find(students(:kvothe).id)
    User.find(users(:elodin).id).update(personable: Teacher.find(teachers(:elodin).id))
    post session_path, params: { email: "elodin@theuniversity.com", password: "password" }
    post student_parents_path(student_id: kvothe.id), params: { parent: { full_name: "Arliden", email: "arlidenthebard@edema.com" } }
    assert_equal "Arliden", Parent.last.full_name
    assert_equal Parent.last, kvothe.parents.last
  end

  test "must be logged in as teacher to create parents" do
    kvothe = Student.find(students(:kvothe).id)
    post student_parents_path(kvothe.id), params: { parent: { full_name: "Arliden", email: "arlidenthebard@edema.com" } }
    assert_redirected_to "/"
    assert_equal "You don't have access to this action", flash[:alert]
  end

end