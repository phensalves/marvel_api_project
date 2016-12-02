# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


if User.all.empty?
  user = User.where(email: 'test@marvel.com')first_or_create( email:                'test@marvel.com',
                                                              password:             '123456',
                                                              password_confirmation:'123456'
                                                            )

  puts "=============================== User -> 'test@marvel.com' <- created successfully and his password is -> '123456' <- ==============================="
end 