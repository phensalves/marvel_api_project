if User.all.empty?
  user = User.where(email: 'test@marvel.com').first_or_create( email:                'test@marvel.com',
                                                              password:             '123456',
                                                              password_confirmation:'123456'
                                                            )

  puts "=============================== User -> 'test@marvel.com' <- created successfully and his password is -> '123456' <- ==============================="
end 