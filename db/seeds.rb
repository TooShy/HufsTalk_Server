# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(uid: 999999999999999, gender: true)
User.create(uid: 111111111111111, gender: true)
Topic.create(topic_name: "공대")
Topic.create(topic_name: "자연대")
Topic.create(topic_name: "어문대")
Topic.create(topic_name: "인문대")
Topic.create(topic_name: "수강신청")
Topic.create(topic_name: "동아리")
Topic.create(topic_name: "교내행사")
Topic.create(topic_name: "외대맛집")
Topic.create(topic_name: "취업")
Topic.create(topic_name: "스터디")
