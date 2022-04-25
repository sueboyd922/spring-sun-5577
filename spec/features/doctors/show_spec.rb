require 'rails_helper'

RSpec.describe 'doctors show page', type: :feature do
  it 'has all of the doctors info' do
    hospital = Hospital.create!(name: "Grey Sloan Memorial Hospital")

    bailey = hospital.doctors.create!(name: "Miranda Bailey", specialty: "General Surgery", university: "Stanford University")
    alex = hospital.doctors.create!(name: "Alex Karev", specialty: "Pediatrics", university: "Iowa State")

    kimmy = Patient.create!(name: "Kimmy", age: 14)
    frank = Patient.create!(name: "Frank", age: 45)
    nick = Patient.create!(name: "Nick", age: 8)

    PatientDoctor.create!(doctor: bailey, patient: kimmy)
    PatientDoctor.create!(doctor: alex, patient: kimmy)
    PatientDoctor.create!(doctor: alex, patient: nick)
    PatientDoctor.create!(doctor: bailey, patient: frank)

    visit "/doctors/#{bailey.id}"
    expect(page).to have_content(bailey.name)
    expect(page).to have_content(bailey.specialty)
    expect(page).to have_content(bailey.university)
    expect(page).to have_content(kimmy.name)
    expect(page).to have_content(frank.name)
    expect(page).to have_content(hospital.name)

    expect(page).not_to have_content(alex.name)
    expect(page).not_to have_content(alex.specialty)
    expect(page).not_to have_content(nick.name)
  end
end