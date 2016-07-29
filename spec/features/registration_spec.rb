feature 'creating new user' do
  scenario 'storing a user profile' do
    sign_up
    expect(page).to have_content 'Welcome, user@user.com'
    expect(User.first.email).to eq('user@user.com')
  end
end

feature 'user sign up' do
  scenario 'user enters mismatching passwords' do
    expect { register(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/user')
    expect(page).to have_content('Passwords do not match')
  end

  scenario 'user needs to enter an email' do
    expect { register(email: '')}.not_to change(User, :count)
    # expect(current_path).to eq('/user')
    # expect(page).to have_content('You need to enter an email address')
  end

  def register(email: 'user@user.com', password: 'user', password_confirmation: 'user')
    visit '/user/new'
    fill_in 'email', :with => email
    fill_in 'password', :with => password
    fill_in 'password_confirmation', :with => password_confirmation
    click_button 'Save user'
  end
end
