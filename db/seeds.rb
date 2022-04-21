# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
[
  ['emp_1', '26'],
  ['emp_2', '27'],
  ['emp_3', '28'],
  ['emp_4', '29'],
  ['emp_5', '30'],
  ['emp_6', '26'],
  ['emp_7', '27'],
  ['emp_8', '28'],
  ['emp_9', '29'],
  ['emp_10', '30'],
].each do |arr|
  Developer.where(name: arr[0]).first_or_create(age: arr[1])
end