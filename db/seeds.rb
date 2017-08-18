require 'faker'

#Destroy everything
User.destroy_all
University.destroy_all
Course.destroy_all

#Creating basic info
password = 123456
gender = ['masculino', 'feminino', 'other']

highschollers_number = 10
undergraduates_number = 50

highschollers_emails = []
undergraduates_emails = []

for i in 1..highschollers_number
  highschollers_emails << "h#{i}@t.c"
end

for i in 1..undergraduates_number
  undergraduates_emails << "u#{i}@t.c"
end

#Creating highschoolers
highschollers_emails.each do |email|
  User.create!(
    email: email,
    password: password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.first_name,
    gender: gender.sample,
    birth_date: Faker::Date.birthday(15, 20),
    city: Faker::Address.city,
    country: Faker::Address.country,
    personal_description: Faker::HowIMetYourMother.quote)
end

#Creating undergraduates
undergraduates_emails.each do |email|
  User.create!(
    email: email,
    password: password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.first_name,
    gender: gender.sample,
    birth_date: Faker::Date.birthday(17, 25),
    city: Faker::Address.city,
    country: Faker::Address.country,
    personal_description: Faker::HowIMetYourMother.quote,
    undergraduate: true)
end

# TO-DO: Fill out all universities emails!
# DO NOT DELETE THIS!!
universities = [
  { name: 'Universidade de São Paulo (USP)', email: 'usp.com' },
  { name: 'Universidade Estadual de Campinas (Unicamp)', email: 'dac.unicamp.com' },
  { name: 'Universidade Federal do Rio de Janeiro (UFRJ)', email: '' },
  { name: 'Universidade Estadual Paulista (Unesp)', email: '' },
  { name: 'Pontifícia Universidade Católica de São Paulo (PUC-SP)', email: '' },
  { name: 'Pontifícia Universidade Católica do Rio de Janeiro (PUC-Rio)', email: '' },
  { name: 'Universidade Federal de São Paulo (Unifesp)', email: '' },
  { name: 'Universidade Federal do Rio Grande do Sul (UFRS)', email: '' } ,
  { name: 'Universidade Federal de Minas Gerais (UFMG)', email: '' },
  { name: 'Universidade de Brasília (UnB)', email: '' },
  { name: 'Universidade Federal de São Carlos (Ufscar)', email: '' },
  { name: 'Universidade Federal de Santa Catarina (Ufsc)', email: '' },
  { name: 'Pontifícia Universidade Católica do Rio Grande do Sul (PUC-RS)' },
  { name: 'Universidade do Estado do Rio de Janeiro (Uerj)', email: '' },
  { name: 'Universidade Estadual de Londrina (UEL)', email: '' },
  { name: 'Universidade Federal da Bahia (UFBA)', email: '' },
  { name: 'Universidade Federal de Santa Maria (UFSM)', email: '' },
  { name: 'Universidade Federal de Viçosa (UFV)', email: '' },
  { name: 'Universidade Federal do Ceará (UFC)', email: '' },
  { name: 'Universidade Federal do Paraná (UFPR)', email: '' },
  { name: 'Universidade Federal de Pernambuco (UFPE)', email: '' },
  { name: 'Universidade Federal Fluminense (UFF)', email: '' }
]



universities.each do |university|
  University.create!(name: university[:name], email: university[:email])
end

# Seed for a restricted number of universities
# universities_number = 10
# for i in 1..universities_number
#   University.create(name: universities.sample)
# end


#Creating courses
courses = [
  "Fonoaudiologia",
  "Administração Pública",
  "Administração",
  "Agronomia",
  "Arquitetura e Urbanismo",
  "Artes Visuais",
  "Biblioteconomia",
  "Biomedicina",
  "Bioquímica e Biotecnologia",
  "Ciência da Computação",
  "Ciência e Tecnologia de Alimentos",
  "Ciências Atuariais",
  "Ciências Biológicas",
  "Ciências Contábeis",
  "Ciências Econômicas",
  "Ciências Sociais",
  "Cinema e Audiovisual",
  "Design",
  "Direito",
  "Educação Física",
  "Enfermagem",
  "Engenharia Aeronáutica",
  "Engenharia Ambiental e Sanitária",
  "Engenharia Bioquímica e de Bioprocessos",
  "Engenharia Civil",
  "Engenharia da Computação",
  "Engenharia de Alimentos",
  "Engenharia de Controle e Automação",
  "Engenharia de Materiais",
  "Engenharia de Minas",
  "Engenharia de Produção",
  "Engenharia de Telecomunicações",
  "Engenharia Elétrica",
  "Engenharia Eletrônica",
  "Engenharia Florestal",
  "Engenharia Mecânica",
  "Engenharia Mecatrônica",
  "Engenharia Metalúrgica",
  "Engenharia Naval",
  "Engenharia Química",
  "Engenharia Têxtil",
  "Esporte",
  "Estatística",
  "Farmácia",
  "Filosofia",
  "Física",
  "Fisioterapia",
  "Fonoaudiologia",
  "Geofísica",
  "Geografia",
  "Geologia",
  "Gerontologia",
  "Gestão Ambiental",
  "História",
  "Informática Biomédica",
  "Jornalismo",
  "Letras",
  "Linguística",
  "Marketing",
  "Matemática",
  "Medicina Veterinária",
  "Medicina",
  "Meteorologia",
  "Música",
  "Nutrição",
  "Obstetrícia",
  "Oceanografia",
  "Odontologia",
  "Pedagogia",
  "Produção Editorial",
  "Psicologia",
  "Publicidade e Propaganda",
  "Química",
  "Relações Internacionais",
  "Relações Públicas",
  "Sistemas de Informação",
  "Teatro",
  "Terapia Ocupacional",
  "Turismo",
  "Zootecnia",
]

courses.each do |course|
  Course.create!(name: course)
end

# Seed for a restricted number of courses
# courses_number = 10
# for i in 1..courses_number
#   Universitie.create(name: courses.sample)
# end

# Creating Resumes
User.all.where(undergraduate: true).each do |undergraduate|
  (rand(3) + 1).times do
    Resume.create!(
      user: undergraduate,
      university: University.order("RANDOM()").first,
      course: Course.order("RANDOM()").first,
      school_email: Faker::Internet.email,
      relative_completion: rand(0..100),
      academic_description: Faker::HitchhikersGuideToTheGalaxy.quote,
      stance: Resume::STANCE.sample,
      email_checked: [true, false].sample
    )
  end
end

# TESTE: E-mail do marco pra testar se o postmark está mandando e-mails corretamente
# Resume.create!(
#     user: User.last,
#     university: University.last,
#     course: Course.last,
#     school_email: "beduschimarco@gmail.com"
# )

# Creating Meetings
duration = [0.5, 1, 1.5, 2]
ratings = [nil, 0, 1, 2, 3, 4, 5]
meetings_number = 200

for i in 1..meetings_number
  randon_times = []
  randon_times << Faker::Time.forward(rand(8), :all) # random time in the next 7 days
  randon_times << Faker::Time.backward(rand(8), :all) # random time in the last 7 days
  start_time = randon_times.sample

  random_undergraduates = User.where(undergraduate: true).order("RANDOM()")
  highschooler = User.where(undergraduate: false).order("RANDOM()").first

  review_title = nil
  review_content = nil
  rating = nil
  if start_time < Time.now
    rating = ratings.sample
    if rating && rand(0) < 0.8
      review_title = Faker::MostInterestingManInTheWorld.quote
      review_content = Faker::Hacker.say_something_smart
    end
  end

  Meeting.create!(
    start_time: start_time,
    end_time: start_time + duration.sample.hour,
    review_title: review_title,
    review_content: review_content,
    rating: rating,
    undergraduate: random_undergraduates.first,
    highschooler: [highschooler, random_undergraduates.first].sample,
    resume: random_undergraduates.first.resumes.sample
    )
end

