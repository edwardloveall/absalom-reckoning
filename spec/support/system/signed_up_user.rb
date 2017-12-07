module SignedUpUser
  def signed_up_user(email: nil, password: '12345')
    email ||= generate(:email)
    SignUpUser.perform(email: email, password: password)
  end
end
