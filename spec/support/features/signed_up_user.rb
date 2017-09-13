module SignedUpUser
  def signed_up_user(email: 'user@example.com', password: '12345')
    SignUpUser.perform(email: email, password: password)
  end
end
